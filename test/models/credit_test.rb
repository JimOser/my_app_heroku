require "test_helper"

class CreditTest < ActiveSupport::TestCase
  def setup
    @author = Role.find_or_create_by!(name: "author")
    @alice  = Person.create!(name: "Alice")
    @bob    = Person.create!(name: "Bob")
    @book   = Book.create!(title: "Test Book")
  end

  test "valid credit persists" do
    c = Credit.new(person: @alice, role: @author, creditable: @book)
    assert c.valid?, c.errors.full_messages.join(", ")
    assert c.save
  end

  test "duplicate credit for same person+role+item is invalid" do
    Credit.create!(person: @alice, role: @author, creditable: @book)
    dup = Credit.new(person: @alice, role: @author, creditable: @book)
    assert_not dup.valid?
    assert_includes dup.errors[:person_id], "already has this role on this item"
  end

  test "book author_ids= creates and removes credits" do
    @book.author_ids = [@alice.id, @bob.id]
    @book.save!
    assert_equal [@alice.id, @bob.id].sort, @book.authors.ids.sort

    @book.author_ids = [@alice.id]
    @book.save!
    assert_equal [@alice.id], @book.authors.ids
  end

  test "author_ids assigned before save are applied after commit" do
    b2 = Book.new(title: "Unsaved Book")
    b2.author_ids = [@alice.id, @bob.id] # set before save
    assert_difference -> { Credit.count }, +2 do
      b2.save!
    end
    assert_equal 2, b2.authors.count
  end

  test "person.authored_books finds via credits" do
    @book.author_ids = [@alice.id]
    @book.save!
    assert_includes @alice.authored_books, @book
    assert_not_includes @bob.authored_books, @book
  end
end

