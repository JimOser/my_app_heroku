class Role < ApplicationRecord
  has_many :people_roles, dependent: :destroy
  has_many :people, through: :people_roles

  # Lista centralizada de roles
  NAMES = %w[author singer host].freeze
end
