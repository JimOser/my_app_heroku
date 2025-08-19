class Credit < ApplicationRecord
  belongs_to :person
  belongs_to :role
  belongs_to :creditable, polymorphic: true

  validates :person_id, :role_id, presence: true
  validates :person_id, uniqueness: { scope: [:creditable_type, :creditable_id, :role_id],
    message: "already has this role on this item" }
end

