class Tile < ActiveRecord::Base
  attr_accessible  :x_location, :y_location
  attr_protected :advertisement_id, :board_id, :cost

  has_one :board, :through => :advertisements
  belongs_to :board
  belongs_to :advertisement

  validates :x_location, presence: true, :numericality => { :greater_than_or_equal_to => 0}
  validates :y_location, presence: true, :numericality => { :greater_than_or_equal_to => 0}
  validates :cost, presence: true, :numericality => {:greater_than_or_equal_to => 0}
  
end
