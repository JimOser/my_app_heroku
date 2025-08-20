class Role < ApplicationRecord
  has_many :credits, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
