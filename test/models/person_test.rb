require "test_helper"

class PersonTest < ActiveSupport::TestCase
  test "should save person with name and bio" do
    person = Person.new(name: "Diego", bio: "Aprendiendo Rails")
    assert person.save
  end
end

