class Tile < ActiveRecord::Base
  attr_accessible :advertisement_id, :board_id, :cost, :x_location, :y_location

  has_one :board, :through => :advertisements
  belongs_to :board
  belongs_to :advertisement
  
end
