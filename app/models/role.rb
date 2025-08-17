class Role < ApplicationRecord
  has_many :people_roles, dependent: :destroy
  has_many :people, through: :people_roles

end
