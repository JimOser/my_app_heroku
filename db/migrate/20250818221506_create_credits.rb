class CreateCredits < ActiveRecord::Migration[7.1]
  def change
    create_table :credits do |t|
      t.references :person, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.references :creditable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
