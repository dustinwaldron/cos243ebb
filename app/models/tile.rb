class Tile < ActiveRecord::Base
  attr_accessible  :x_location, :y_location, :cost
  attr_protected :advertisement_id, :board_id, :cost

  belongs_to :advertisement
  has_one :board, :through => :advertisement

  validates :x_location, presence: true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0}
  validates :y_location, presence: true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0}
  validates :cost, presence: true, :numericality => {:greater_than_or_equal_to => 0}
  
  validate :size_check

  #Do stuff
  def age
      for x in x_location..(x_location + width - 1) do
        for y in y_location..(y_location + height - 1) do
          tile = board.tiles.where(:x_location => x, :y_location => y).first
          tile_cost = tile.cost.to_f
          tile_cost = tile_cost * 0.5
          if tile_cost < 0.01
            tile_cost = 0.0
          end
          tile.cost = tile_cost
        end
      end
  end

  private
  	def size_check
  		if x_location.is_a?(Integer) && y_location.is_a?(Integer)
  			if x_location >= board.width
  				errors.add(:x_location, "can't be larger than the board width")
  			end

  			if x_location < advertisement.x_location
  				errors.add(:x_location, "can't be smallerr thand the advertisement x_location")
  			end

  			if x_location > (advertisement.x_location + advertisement.width - 1)
  				errors.add(:x_location, "can't be larger than the advertisement width")
  			end

  			if y_location >= board.height
  				errors.add(:y_location, "can't be bigger than the board height")
  			end

  			if y_location < advertisement.y_location
  				errors.add(:y_location, "can't be smaller than the advertisement y_location")
  			end

  			if y_location > (advertisement.y_location + advertisement.height-1)
  				errors.add(:y_location, "can't be larger than the advertisement height")
  			end
  		end
  	end

end
