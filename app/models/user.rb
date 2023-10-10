class User < ApplicationRecord
  # For temporary users, assign email of +++TEMP+++<invitee email>, username=ADJ-NOUN, password=random-16-bytes
  validates :username, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 150 }, format: { with: /.+@.+\.\w/, uniqueness: true }
  has_secure_password
end
