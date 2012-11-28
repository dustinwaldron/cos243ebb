class Advertisement < ActiveRecord::Base
  attr_accessible :height, :image, :width, :x_location, :y_location
  attr_protected :board_id, :user_id

  has_many :payment_details, as: :payables
  has_many :tiles
  belongs_to :board 
  belongs_to :user

  validates :x_location, presence: true, :numericality => { :greater_than_or_equal_to => 0}
  validates :y_location, presence: true, :numericality => { :greater_than_or_equal_to => 0}
  validates :width, presence: true, :numericality => { :greater_than_or_equal_to => 1}
  validates :height,  presence: true, :numericality => { :greater_than_or_equal_to => 1}
  validates :image, presence: true

end
