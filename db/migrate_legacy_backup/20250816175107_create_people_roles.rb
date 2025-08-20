class CreatePeopleRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :people_roles do |t|
      t.references :person, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.boolean :main_author, default: false, null: false
      t.timestamps
    end

    # Ensure a person can only have each role once
    add_index :people_roles, [:person_id, :role_id], unique: true
  end
end

