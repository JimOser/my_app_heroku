class Book < ApplicationRecord
  include Creditable
  credit_roles :author

  validates :title, presence: true
end
