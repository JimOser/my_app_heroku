class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.string :title
      t.date :released_on
      t.string :youtube_url
      t.string :spotify_url
      t.references :singer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
