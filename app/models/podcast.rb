class Podcast < ApplicationRecord
  belongs_to :person   # assuming host is a Person
  has_many :episodes, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
end

