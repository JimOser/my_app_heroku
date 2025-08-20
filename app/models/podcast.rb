class Podcast < ApplicationRecord
  include Creditable
  credit_roles :host

  has_many :episodes, dependent: :destroy

  validates :title, presence: true
end
