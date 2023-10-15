class User < ApplicationRecord
  # For temporary users, assign email of +++TEMP+++<invitee email>, username=ADJ-NOUN, password=random-16-bytes
  validates :username, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 150 },
    format: { with: /.+@.+\.\w/ }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4 }

  has_secure_password

  before_save :check_temporaries

  def check_temporaries
    if self.is_temporary.nil?
      self.is_temporary = false
    end
    self.email = email.downcase
  end
end
