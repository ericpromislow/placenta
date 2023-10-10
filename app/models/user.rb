class User < ApplicationRecord
  validates :username, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 150 }, format: { with: /\..+@\w/, uniqueness: true }
  has_secure_password
end
