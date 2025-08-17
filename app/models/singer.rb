class Singer < ApplicationRecord
  has_many :songs, dependent: :destroy
end

