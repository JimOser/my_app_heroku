class Person < ApplicationRecord
  has_many :people_roles, dependent: :destroy
  has_many :roles, through: :people_roles

  has_many :books
  has_many :podcasts
  has_many :songs
end
