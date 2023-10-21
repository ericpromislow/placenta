class User < ApplicationRecord
  # For temporary users, assign email of +++TEMP+++<invitee email>, username=ADJ-NOUN, password=random-16-bytes

  attr_accessor :remember_token
  before_save :do_before_save
  validates :username, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 150 },
    format: { with: /.+@.+\.\w/ }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 4 }

  def do_before_save
    if self.is_temporary.nil?
      self.is_temporary = false
    end
    self.email = email.downcase
  end

  def authenticated?(a_remember_token)
    # Does encrypting a_remember_token match the current remember_digest?
    a_remember_token && BCrypt::Password.new(remember_digest).is_password?(a_remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  def User.digest(raw_password)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(raw_password, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end
end
