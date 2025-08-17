class Episode < ApplicationRecord
  belongs_to :podcast
  validates :title, :number, presence: true
end
