class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :url
      t.date :published_on
      t.references :person, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
