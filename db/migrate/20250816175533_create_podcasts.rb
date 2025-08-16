class CreatePodcasts < ActiveRecord::Migration[7.1]
  def change
    create_table :podcasts do |t|
      t.string :title
      t.text :description
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
