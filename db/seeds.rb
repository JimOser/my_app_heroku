puts "➡️ Seeding Roles..."
roles = %w[author singer host]
roles.each do |role_name|
  Role.find_or_create_by!(name: role_name)
end

puts "➡️ Creating People..."
walter = Person.find_or_create_by!(name: "Walter Freiburg", bio: "Writer and podcaster")
walter.roles = [Role.find_by!(name: "author"), Role.find_by!(name: "host")]
walter.save!

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

puts "➡️ Creating Singers..."
adele = Person.find_or_create_by!(name: "Adele", bio: "Famous singer")
adele.roles = [Role.find_by!(name: "singer")]
adele.save!

puts "➡️ Creating Songs..."
Song.find_or_create_by!(title: "Hello", person: adele) do |song|
  song.released_on = Date.parse("2015-10-23")
  song.youtube_url = "https://youtube.com/hello"
  song.spotify_url = "https://spotify.com/hello"
end

Song.find_or_create_by!(title: "Rolling in the Deep", person: adele) do |song|
  song.released_on = Date.parse("2010-11-29")
end

puts "✅ Seeding complete!"

