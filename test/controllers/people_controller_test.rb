require "test_helper"

class PeopleControllerTest < ActionDispatch::IntegrationTest
  # Only load people fixtures to avoid issues with books or other tables
  fixtures :people

  setup do
    @person = people(:one)  # Walter Freiburg
  end

  test "should get index" do
    get people_url
    assert_response :success
  end

  test "should get new" do
    get new_person_url
    assert_response :success
  end

  test "should create person" do
    assert_difference("Person.count") do
      post people_url, params: { person: { name: "Diego", bio: "Aprendiendo Rails" } }
    end
    new_person = Person.last
    assert_redirected_to person_url(new_person)
  end

  test "should show person" do
    get person_url(@person)
    assert_response :success
  end

  test "should get edit" do
    get edit_person_url(@person)
    assert_response :success
  end

  test "should update person" do
    patch person_url(@person), params: { person: { name: "Walter Updated" } }
    assert_redirected_to person_url(@person)
    @person.reload
    assert_equal "Walter Updated", @person.name
  end

  test "should destroy person" do
    # Create a temporary person with no associated books to avoid FK violation
    temp_person = Person.create!(name: "Temp Person", bio: "Temporary for destroy test")

    assert_difference("Person.count", -1) do
      delete person_url(temp_person)
    end

    assert_redirected_to people_url
  end
end

