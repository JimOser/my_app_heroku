# app/models/song.rb
class Song < ApplicationRecord
  belongs_to :singer, class_name: "Person", inverse_of: :songs
end

