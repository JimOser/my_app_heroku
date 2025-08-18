# app/models/episode.rb
class Episode < ApplicationRecord
  belongs_to :podcast, inverse_of: :episodes
end

