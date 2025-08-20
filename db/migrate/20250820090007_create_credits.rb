class CreateCredits < ActiveRecord::Migration[7.1]
  def change

    create_table :credits do |t|
      t.references :person, null: false, foreign_key: true
      t.references :role,   null: false, foreign_key: true
      t.string     :creditable_type, null: false
      t.bigint     :creditable_id,   null: false
      t.timestamps
    end
    add_index :credits, [:creditable_type, :creditable_id]
    add_index :credits, [:creditable_type, :creditable_id, :person_id, :role_id],
              unique: true, name: "idx_unique_credit"
  end
end
