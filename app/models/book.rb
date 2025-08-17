class Book < ApplicationRecord
  belongs_to :author, class_name: "Person"
end
