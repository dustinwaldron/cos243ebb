class Advertisement < ActiveRecord::Base
  attr_accessible :height, :image, :width, :x_location, :y_location
  attr_protected :board_id, :user_id

  has_many :payment_details, :as => :payable
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

  before_create :make_tiles
  after_create :charge


  def charge
  	total_cost = 0.0 
  	if !(board.payment_detail.nil?)
  		for x in x_location..(x_location + width - 1) do
  			for y in y_location..(y_location + height - 1) do
  				tile_cost = board.tiles.where(:x_location => x, :y_location => y).first[:cost]
  				total_cost = total_cost + tile_cost.to_f
  			end
  		end
  		pd = payment_details.create(:amount => total_cost) #use total_cost in place of width x height
  		pd.user = user
  	end
  end

  def make_tiles
	  	for x in x_location..(x_location + width - 1) do 
	  		for y in y_location..(y_location + height - 1) do
	  			t = board.tiles.where(:x_location => x, :y_location => y).first
	  			if t.nil?
		  			t = tiles.build(:x_location => x, :y_location => y)
		  			t.cost = 0
		  		else
		  			prev_cost = t[:cost]
		  			t.destroy
		  			t = tiles.build(:x_location => x, :y_location => y)
		  			new_cost = 2 * prev_cost
		  			if new_cost < 1
		  				new_cost = 1
		  			end
		  			new_cost = new_cost.to_f
		  			t[:cost] = new_cost
		  		end

	  		end
	  	end
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
