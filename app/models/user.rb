class User < ActiveRecord::Base

  attr_accessible :email, :name, :password_digest, :remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  has_many :payment_details
  has_many :boards
  has_many :advertisments
end
