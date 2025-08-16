class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rating
      t.references :reviewable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
