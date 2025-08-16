class CreatePeopleRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :people_roles do |t|
      t.references :person, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
