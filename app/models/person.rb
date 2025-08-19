# app/models/person.rb
class Person < ApplicationRecord
  validates :name, presence: true

  # --- Legacy direct associations (kept for now so existing pages keep working) ---
  has_many :books,    foreign_key: :author_id, inverse_of: :author
  has_many :podcasts, foreign_key: :person_id,  inverse_of: :person
  has_many :songs,    foreign_key: :singer_id,  inverse_of: :singer

  # Legacy person-level roles (via PeopleRole) — still present until full DRY migration
  has_many :people_roles
  has_many :roles, through: :people_roles

  # --- DRY backbone via credits (new) ---
  has_many :credits, dependent: :destroy

  # Books this person authored (role = "author")
  has_many :authored_book_credits,
           -> { where(creditable_type: "Book").joins(:role).where(roles: { name: "author" }) },
           class_name: "Credit"
  has_many :authored_books, through: :authored_book_credits, source: :creditable, source_type: "Book"

  # (Ready for later steps)
  has_many :sung_song_credits,
           -> { where(creditable_type: "Song").joins(:role).where(roles: { name: "singer" }) },
           class_name: "Credit"
  has_many :sung_songs, through: :sung_song_credits, source: :creditable, source_type: "Song"

  has_many :hosted_podcast_credits,
           -> { where(creditable_type: "Podcast").joins(:role).where(roles: { name: "host" }) },
           class_name: "Credit"
  has_many :hosted_podcasts, through: :hosted_podcast_credits, source: :creditable, source_type: "Podcast"
end

