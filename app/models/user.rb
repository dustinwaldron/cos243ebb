class User < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest, :remember_token

  has_many :payment_details
  has_many :boards
  has_many :advertisments
end
