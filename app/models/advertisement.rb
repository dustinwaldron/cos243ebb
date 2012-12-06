class Advertisement < ActiveRecord::Base
  attr_accessible :height, :image, :width, :x_location, :y_location
  attr_protected :board_id, :user_id

  has_many :payment_details, as: :payable
  has_many :tiles
  belongs_to :board 
  belongs_to :user

  validates :x_location, presence: true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0}
  validates :y_location, presence: true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0}
  validates :width, presence: true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1}
  validates :height,  presence: true, :numericality => { :only_integer => true , :greater_than_or_equal_to => 1}
  validates :image, presence: true

  validates :board, presence: true

  validate :size_check

  #after_save :make_tiles



  def make_tiles
  	for x in x_location..(x_location + width) do 
  		for y in y_location..(y_location + height) do
  			tile = tiles.build()
  			tile.advertisement = self
  			tile.x_location = x
  			tile.y_location = y
  			tile.cost = 1
  		end
  	end
  end

  def calculate_cost
  	@current_board = Board.find_by_id(board_id)
  	@all_tiles = Tile.find(:all, :conditions => { :x_location => x_location, :y_location => y_location, :advertisement_id => advertisement_id})

  end

  #Do stuff
  def charge
  end

  def image_contents=(object)
	self.image = object.read()
  end

  private 
  def size_check
		if x_location.is_a?(Integer) && y_location.is_a?(Integer) && width.is_a?(Integer) && height.is_a?(Integer)
			if x_location >= board.width
				errors.add(:x_location, "can't be larger than the board width")
			end

			if y_location >= board.height
				errors.add(:y_location, "can't be larger than the board height")
			end

			if width > board.width
				errors.add(:width, "can't be larger than the board width")
			end

			if height > board.height
				errors.add(:height, "can't be larger than  the board height")
			end

			if x_location + width > board.width
				errors.add(:x_location, "combined can't be larger than the board width")
			end

			if y_location + height > board.height
				errors.add(:y_location, "combined can't be larger than the board height")
			end
		end
	end

end
