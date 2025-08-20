class CreateBooks < ActiveRecord::Migration[7.1]
  def change

    create_table :books do |t|
      t.string :title, null: false
      t.string :url
      t.date   :published_on
      t.integer :status
      t.timestamps
    end
    add_check_constraint :books, "char_length(btrim(title)) > 0", name: "books_title_not_blank"
  end
end
