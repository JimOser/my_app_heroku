# app/models/podcast.rb
class Podcast < ApplicationRecord
  belongs_to :person,  inverse_of: :podcasts
  has_many   :episodes, dependent: :destroy
end

