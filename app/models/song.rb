class Song < ApplicationRecord
  belongs_to :singer, class_name: "Person"
end

