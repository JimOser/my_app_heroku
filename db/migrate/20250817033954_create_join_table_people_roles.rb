class CreateJoinTablePeopleRoles < ActiveRecord::Migration[7.1]
  def change
    create_join_table :people, :roles do |t|
      t.index [:person_id, :role_id], unique: true
      t.index [:role_id, :person_id]
    end
  end
end
