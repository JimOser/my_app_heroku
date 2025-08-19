# db/seeds.rb

puts "➡️ Seeding Roles..."
author_role = Role.find_or_create_by!(name: "author")
singer_role = Role.find_or_create_by!(name: "singer")
host_role   = Role.find_or_create_by!(name: "host")

puts "➡️ Creating People..."
walter = Person.find_or_create_by!(name: "Walter Freiburg") { |p| p.bio = "Writer and podcaster" }
adele  = Person.find_or_create_by!(name: "Adele")           { |p| p.bio = "Famous singer" }

puts "➡️ Linking People ↔ Roles (legacy PeopleRole join, idempotent)..."
pr = PeopleRole.find_or_initialize_by(person: walter, role: author_role)
pr.main_author = true
pr.save!
PeopleRole.find_or_create_by!(person: walter, role: host_role)
PeopleRole.find_or_create_by!(person: adele,  role: singer_role)

puts "➡️ Creating Books..."
book = Book.find_or_create_by!(title: "Rails and Beyond")
book.update!(
  url:           "https://walterfreiburg.com/rails",
  published_on:  Date.new(2023, 5, 1),
  # status: set this only if you have an enum you want to exercise, e.g. :reading
  # status: :reading,
  author:        walter
)

puts "➡️ Creating Podcasts..."
pod = Podcast.find_or_create_by!(title: "Tech Talks with Walter")
pod.update!(
  description: "Conversations about programming and technology",
  person:      walter
)

puts "➡️ Creating Episodes..."
Episode.find_or_create_by!(podcast: pod, number: 1) do |e|
  e.title       = "Rails Deep Dive"
  e.url         = "https://example.com/ep1"
  e.youtube_url = "https://youtube.com/ep1"
  e.released_on = Date.new(2024, 1, 1)
end

Episode.find_or_create_by!(podcast: pod, number: 2) do |e|
  e.title       = "Ruby Magic Tricks"
  e.released_on = Date.new(2024, 2, 1)
end

puts "➡️ Creating Songs..."
song1 = Song.find_or_create_by!(title: "Hello")
song1.update!(
  released_on: Date.new(2015, 10, 23),
  youtube_url: "https://youtube.com/hello",
  spotify_url: "https://spotify.com/hello",
  singer:      adele
)

song2 = Song.find_or_create_by!(title: "Rolling in the Deep")
song2.update!(
  released_on: Date.new(2010, 11, 29),
  singer:      adele
)

puts "✅ Seeding complete!"

