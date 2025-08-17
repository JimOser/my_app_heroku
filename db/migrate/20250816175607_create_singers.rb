class CreateSingers < ActiveRecord::Migration[7.1]
  def change
    create_table :singers do |t|
      t.string :name
      t.text :bio

      t.timestamps
    end
  end
end
