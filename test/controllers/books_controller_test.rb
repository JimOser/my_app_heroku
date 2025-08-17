require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  fixtures :books, :people

  setup do
    @book = books(:one)
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should get new" do
    get new_book_url
    assert_response :success
  end

  test "should create book" do
    assert_difference("Book.count") do
      post books_url, params: { book: { title: "New Book", url: "http://example.com/new", published_on: Date.today, author: people(:two) } }
    end
    assert_redirected_to book_url(Book.last)
  end

  test "should show book" do
    get book_url(@book)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_url(@book)
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book), params: { book: { title: "Updated Title" } }
    assert_redirected_to book_url(@book)
    @book.reload
    assert_equal "Updated Title", @book.title
  end

  test "should destroy book" do
    temp_book = Book.create!(title: "Temp", url: "http://example.com/temp", published_on: Date.today, author: people(:one))
    assert_difference("Book.count", -1) do
      delete book_url(temp_book)
    end
    assert_redirected_to books_url
  end
end

