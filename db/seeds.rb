puts "➡️ Seeding Roles..."
ROLE_NAMES = %w[author singer host].freeze
ROLE_NAMES.each do |role_name|
  Role.find_or_create_by!(name: role_name)
end

puts "➡️ Creating People..."
walter = Person.find_or_create_by!(name: "Walter Freiburg") do |p|
  p.bio = "Writer and podcaster"
end

puts "➡️ Assigning Roles to Walter..."
# Author (main_author)
PeopleRole.find_or_create_by!(person: walter, role: Role.find_by!(name: "author")) do |pr|
  pr.main_author = true
end
# Host
PeopleRole.find_or_create_by!(person: walter, role: Role.find_by!(name: "host")) do |pr|
  pr.main_author = false
end
# Singer
PeopleRole.find_or_create_by!(person: walter, role: Role.find_by!(name: "singer")) do |pr|
  pr.main_author = false
end

puts "➡️ Creating Books..."
Book.find_or_create_by!(title: "Rails and Beyond") do |book|
  book.url = "https://walterfreiburg.com/rails"
  book.published_on = Date.new(2023, 5, 1)
  book.author = walter
  book.status = :reading
end

puts "➡️ Creating Podcasts..."
podcast = Podcast.find_or_create_by!(title: "Tech Talks with Walter") do |p|
  p.person = walter
  p.description = "Conversations about programming and technology"
end

puts "➡️ Creating Episodes..."
Episode.find_or_create_by!(podcast: podcast, number: 1) do |ep|
  ep.title = "Rails 8 Deep Dive"
  ep.url = "https://example.com/ep1"
  ep.youtube_url = "https://youtube.com/ep1"
  ep.released_on = Date.new(2024, 1, 1)
end

puts "➡️ Creating Singers..."
adele = Singer.find_or_create_by!(name: "Adele") do |s|
  s.bio = "English singer and songwriter"
end

puts "➡️ Creating Songs..."
Song.find_or_create_by!(title: "Hello") do |song|
  song.singer = adele
  song.released_on = Date.new(2015, 10, 23)
  song.youtube_url = "https://youtube.com/hello"
  song.spotify_url = "https://open.spotify.com/track/hello"
end

puts "✅ Seeds loaded successfully!"

