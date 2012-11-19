class Advertisement < ActiveRecord::Base
  attr_accessible :board_id, :height, :image, :user_id, :width, :x_location, :y_location

  has_many :payment_details, as: :payable
  has_many :tiles
  belongs_to :board 
  belongs_to :user

end
