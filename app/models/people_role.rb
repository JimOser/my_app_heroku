class PeopleRole < ApplicationRecord
  belongs_to :person
  belongs_to :role

  # convenient scope
  scope :main_authors, -> { where(main_author: true) }
end
