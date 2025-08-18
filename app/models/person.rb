# app/models/person.rb
class Person < ApplicationRecord
  has_many :books,    foreign_key: :author_id, inverse_of: :author
  has_many :podcasts, foreign_key: :person_id, inverse_of: :person
  has_many :songs,    foreign_key: :singer_id, inverse_of: :singer

  has_many :people_roles
  has_many :roles, through: :people_roles
end

