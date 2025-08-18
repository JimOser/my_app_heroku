# app/models/book.rb
class Book < ApplicationRecord
  belongs_to :author, class_name: "Person", inverse_of: :books
end

