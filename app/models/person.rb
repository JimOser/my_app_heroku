class Person < ApplicationRecord
  validates :name, presence: true
  has_many :credits, dependent: :destroy

  # Books authored (role = "author")
  has_many :authored_book_credits,
           -> { where(creditable_type: "Book").joins(:role).where(roles: { name: "author" }) },
           class_name: "Credit"
  has_many :authored_books, through: :authored_book_credits, source: :creditable, source_type: "Book"

  # Songs sung (role = "singer")
  has_many :sung_song_credits,
           -> { where(creditable_type: "Song").joins(:role).where(roles: { name: "singer" }) },
           class_name: "Credit"
  has_many :sung_songs, through: :sung_song_credits, source: :creditable, source_type: "Song"

  # Podcasts hosted (role = "host")
  has_many :hosted_podcast_credits,
           -> { where(creditable_type: "Podcast").joins(:role).where(roles: { name: "host" }) },
           class_name: "Credit"
  has_many :hosted_podcasts, through: :hosted_podcast_credits, source: :creditable, source_type: "Podcast"
end
