class User < ActiveRecord::Base

  attr_accessible :email, :name, :password_digest, :remember_token
  attr_protected :admin

  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save {self.email.downcase!}
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true

  has_many :payment_details
  has_many :boards
  has_many :advertisments

  private
  	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end

end
