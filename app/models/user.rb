require 'bcrypt'
class User < ApplicationRecord
	has_many :favorites
	has_many :addresses, through: :favorites
  validates :name, :email, :password, :password_confirm, presence: true 

	attr_accessor :password_confirm, :reset_token

	def verify(password)
		self.password == password
	end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now!
  end

	def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end
# def generate_password_token!
#  self.reset_password_token = generate_token
#  self.reset_password_sent_at = Time.now.utc
#  save!
# end

# def password_token_valid?
#  (self.reset_password_sent_at + 4.hours) > Time.now.utc
# end

# def reset_password!(password)
#  self.reset_password_token = nil
#  self.password = password
#  save!
# end

# private

# def generate_token
#  SecureRandom.hex(10)
# end

end
