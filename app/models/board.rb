class Board < ActiveRecord::Base
  attr_accessible :height, :name, :timezone, :user_id, :width

  belongs_to :user
  has_many :tiles, :through => :advertisements
  has_one :payment_detail, as: :payable
end
