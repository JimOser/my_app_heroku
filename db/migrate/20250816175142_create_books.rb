class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :url
      t.date :published_on
      t.references :author, null: false, foreign_key: { to_table: :people }

      t.integer :status

      t.timestamps
    end
  end
end
