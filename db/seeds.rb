# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
Review.destroy_all
Episode.destroy_all
Podcast.destroy_all
Book.destroy_all
Song.destroy_all
Person.destroy_all

walter = Person.create!(name: "Walter Freiburg", bio: "Writer and podcaster")
walter.roles << Role.find_by!(name: "author")
walter.roles << Role.find_by!(name: "host")

Book.create!(
  title: "Rails and Beyond",
  url: "https://walterfreiburg.com/rails",
  published_on: "2023-05-01",
  person: walter,
  status: :reading
)

podcast = Podcast.create!(
  title: "Tech Talks with Walter",
  person: walter,
  description: "Conversations about programming and technology"
)

Episode.create!(
  podcast: podcast,
  number: 1,
  title: "Rails 8 Deep Dive",
  url: "https://example.com/ep1",
  youtube_url: "https://youtube.com/ep1",
  released_on: "2024-01-01"
)
