puts "➡️ Seeding Roles..."
author_role = Role.find_or_create_by!(name: "author")
singer_role = Role.find_or_create_by!(name: "singer")
host_role   = Role.find_or_create_by!(name: "host")

puts "➡️ Creating People..."
walter = Person.find_or_create_by!(name: "Walter Freiburg", bio: "Writer and podcaster")
walter.save!
PeopleRole.create!(person: walter, role: author_role, main_author: true)
PeopleRole.create!(person: walter, role: host_role)

adele = Person.find_or_create_by!(name: "Adele", bio: "Famous singer")
adele.save!
PeopleRole.create!(person: adele, role: singer_role)

puts "➡️ Creating Books..."
Book.find_or_create_by!(title: "Rails and Beyond") do |book|
  book.author = walter
  book.url = "https://walterfreiburg.com/rails"
  book.published_on = Date.parse("2023-05-01")
  book.status = :reading
end

puts "➡️ Creating Podcasts..."
tech_talks = Podcast.find_or_create_by!(title: "Tech Talks with Walter", person: walter) do |podcast|
  podcast.description = "Conversations about programming and technology"
end

puts "➡️ Creating Episodes..."
Episode.find_or_create_by!(podcast: tech_talks, number: 1) do |episode|
  episode.title = "Rails Deep Dive"
  episode.url = "https://example.com/ep1"
  episode.youtube_url = "https://youtube.com/ep1"
  episode.released_on = Date.parse("2024-01-01")
end

Episode.find_or_create_by!(podcast: tech_talks, number: 2) do |episode|
  episode.title = "Ruby Magic Tricks"
  episode.released_on = Date.parse("2024-02-01")
end

puts "➡️ Creating Songs..."
Song.find_or_create_by!(title: "Hello", singer: adele) do |song|
  song.released_on = Date.parse("2015-10-23")
  song.youtube_url = "https://youtube.com/hello"
  song.spotify_url = "https://spotify.com/hello"
end

Song.find_or_create_by!(title: "Rolling in the Deep", singer: adele) do |song|
  song.released_on = Date.parse("2010-11-29")
end

puts "✅ Seeding complete!"

