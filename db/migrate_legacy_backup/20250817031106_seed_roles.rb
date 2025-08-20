class SeedRoles < ActiveRecord::Migration[7.1]
  def up
    %w[author singer host].each do |role|
      Role.find_or_create_by!(name: role)
    end
  end

  def down
    Role.where(name: %w[author singer host]).destroy_all
  end
end

