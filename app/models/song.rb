class Song < ApplicationRecord
  include Creditable
  credit_roles :singer

  validates :title, presence: true
end
