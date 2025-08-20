puts "➡️ Seeding roles..."
%w[author singer host].each { |r| Role.find_or_create_by!(name: r) }

puts "➡️ Creating people..."
pl = Person.find_or_create_by!(name: "P.L. Travers") { |p| p.bio = "Author of Mary Poppins." }

walter = Person.find_or_create_by!(name: "Walter Freiberg") do |p|
  p.bio = <<~BIO.squish
    Mi nombre es Walter Freiberg y nací en Buenos Aires, Argentina. Me gusta aprender todo tipo de cosas: idiomas, música, escritura y otras cosas. Lo que más me fascina es el proceso de aprendizaje: es decir, «aprender a aprender». Me encanta compartir mis conocimientos sobre el proceso de aprendizaje y ayudar a otras personas a aprender mejor. Mi propósito es empoderar a las personas para que alcancen su potencial y aspiraciones de aprendizaje.
    Website: https://poderaprender.com/ • YouTube: https://www.youtube.com/@poder-aprender
  BIO
end

shakira = Person.find_or_create_by!(name: "Shakira") { |p| p.bio = "Singer." }
carlos  = Person.find_or_create_by!(name: "Carlos Vives") { |p| p.bio = "Singer." }

karo = Person.find_or_create_by!(name: "Karo Martinez") do |p|
  p.bio = <<~BIO.squish
    When I was six, I got a book about the 100 wonders of the world... Today, I teach the language that changed my life.
    Website: https://www.espanolautomatico.com/ • YouTube: https://www.youtube.com/c/EspanolAutomatico
  BIO
end

puts "➡️ Books via Credits..."
mary = Book.find_or_create_by!(title: "Mary Poppins"); mary.author_ids = [pl.id]; mary.save!
ana  = Book.find_or_create_by!(title: "Spanish Novels: Ana, Estudiante");  ana.author_ids  = [walter.id]; ana.save!
futb = Book.find_or_create_by!(title: "Spanish Novels: Fútbol en Madrid"); futb.author_ids = [walter.id]; futb.save!
tsu  = Book.find_or_create_by!(title: "Tsunami");                           tsu.author_ids  = [walter.id]; tsu.save!
b1   = Book.find_or_create_by!(title: "30 días para entender español hablado"); b1.author_ids = [karo.id]; b1.save!
b2   = Book.find_or_create_by!(title: "Mi vida en Barcelona");                 b2.author_ids = [karo.id]; b2.save!

puts "➡️ Songs via Credits..."
ea   = Song.find_or_create_by!(title: "Estoy Aquí"); ea.singer_ids = [shakira.id]; ea.save!
sw   = Song.find_or_create_by!(title: "She Wolf");   sw.singer_ids = [shakira.id]; sw.save!
bici = Song.find_or_create_by!(title: "La Bicicleta"); bici.youtube_url = "https://www.youtube.com/watch?v=-UV0QGLmYys"; bici.singer_ids = [shakira.id, carlos.id]; bici.save!

puts "➡️ Podcast via Credits..."
pod = Podcast.find_or_create_by!(title: "Poder aprender")
pod.update!(description: "Podcast de Walter Freiberg sobre aprendizaje (poderaprender.com).")
pod.host_ids = [walter.id]; pod.save!

puts "➡️ Creating episodes..."
# add_index :episodes, [:podcast_id, :number], unique: true

episodes = [
  { number: 100, title: "Hábitos para un aprendizaje continuo", url: "https://poderaprender.com/captivate-podcast/100-habitos-para-un-aprendizaje-continuo/", youtube_url: "https://www.youtube.com/watch?v=kW0LtPyVjcA" },
  { number: 1, title: "Aprender idiomas a tu manera", url: "https://poderaprender.com/captivate-podcast/1-aprender-idiomas-a-tu-manera/", youtube_url: "https://www.youtube.com/watch?v=IcpAj7g0TaA" }
]

numbers = episodes.map { |e| e[:number] }
existing_created_at =
  Episode.where(podcast_id: pod.id, number: numbers)
         .pluck(:number, :created_at)
         .to_h

rows = episodes.map do |e|
  {
    podcast_id:  pod.id,
    number:      e[:number],
    title:       e[:title],
    url:         e[:url],
    youtube_url: e[:youtube_url],
    # Preserve created_at if the row already exists; set it on insert
    created_at:  existing_created_at[e[:number]] || Time.current,
    updated_at:  Time.current
  }
end

Episode.upsert_all(rows, unique_by: %i[podcast_id number])

puts "✅ Seeding complete."
