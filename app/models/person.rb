class Person < ApplicationRecord
  has_many :people_roles, dependent: :destroy, inverse_of: :person
  has_many :roles, through: :people_roles

  has_many :books
  has_many :podcasts
  has_many :songs, foreign_key: :singer_id

  accepts_nested_attributes_for :people_roles, allow_destroy: true

  # Virtual attribute used by RailsAdmin for multi-select
  def role_names
    roles.pluck(:name)
  end

  def role_names=(names)
    self.roles = Role.where(name: Array(names).reject(&:blank?))
  end
end

