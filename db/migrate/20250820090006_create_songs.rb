class CreateSongs < ActiveRecord::Migration[7.1]
  def change

    create_table :songs do |t|
      t.string :title, null: false
      t.date   :released_on
      t.string :youtube_url
      t.string :spotify_url
      t.timestamps
    end
    add_check_constraint :songs, "char_length(btrim(title)) > 0", name: "songs_title_not_blank"
  end
end
