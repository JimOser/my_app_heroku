class CreateEpisodes < ActiveRecord::Migration[7.1]
  def change

    create_table :episodes do |t|
      t.references :podcast, null: false, foreign_key: true
      t.integer :number
      t.string  :title
      t.string  :url
      t.string  :youtube_url
      t.date    :released_on
      t.timestamps
    end
    add_index :episodes, [:podcast_id, :number], unique: true
  end
end
