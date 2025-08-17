require "test_helper"

class EpisodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = Person.create!(name: "Walter Freiburg", bio: "Writer and podcaster")
    @podcast = Podcast.create!(title: "Tech Talks", description: "Programming topics", person: @person)
    @episode = @podcast.episodes.create!(title: "Rails Deep Dive", number: 1, released_on: "2024-01-01")
  end

  test "should get index" do
    get podcast_episodes_url(@podcast)
    assert_response :success
    assert_select "h1", "Episodes"
  end

  test "should get new" do
    get new_podcast_episode_url(@podcast)
    assert_response :success
    assert_select "h1", "New Episode"
  end

  test "should create episode" do
    assert_difference('@podcast.episodes.count', 1) do
      post podcast_episodes_url(@podcast), params: {
        episode: { title: "Rails Advanced", number: 2, released_on: "2024-02-01" }
      }
    end
    assert_redirected_to podcast_episode_path(@podcast, Episode.last)
  end

  test "should show episode" do
    get podcast_episode_url(@podcast, @episode)
    assert_response :success
    assert_select "h1", @episode.title
  end

  test "should get edit" do
    get edit_podcast_episode_url(@podcast, @episode)
    assert_response :success
    assert_select "h1", "Edit Episode"
  end

  test "should update episode" do
    patch podcast_episode_url(@podcast, @episode), params: { episode: { title: "Rails Deep Dive Updated" } }
    assert_redirected_to podcast_episode_path(@podcast, @episode)
    @episode.reload
    assert_equal "Rails Deep Dive Updated", @episode.title
  end

  test "should destroy episode" do
    assert_difference('@podcast.episodes.count', -1) do
      delete podcast_episode_url(@podcast, @episode)
    end
    assert_redirected_to podcast_episodes_path(@podcast)
  end
end

