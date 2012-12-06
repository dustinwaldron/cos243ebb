class Board < ActiveRecord::Base
  attr_accessible :height, :name, :timezone, :width
  attr_protected :user_id

  validates :height, presence: true, :numericality => {:only_integer => true, greater_than: 0}
  validates :width, presence: true,:numericality => {:only_integer => true, greater_than: 0 }

  belongs_to :user
  has_many :tiles, :through => :advertisements
  has_many :advertisements
  has_one :payment_detail, as: :payable

  validates :name, presence: true, length: {minimum: 1}
  validates :width, presence: true, :numericality => { :only_integer => true, greater_than_or_equal_to: 1}
  validates :height, presence: true, :numericality => { :only_integer => true, greater_than_or_equal_to: 1}
  validates :timezone, presence: true
  validates_inclusion_of :timezone, in: ActiveSupport::TimeZone.zones_map { |m| m.name }, message: "is not a valid Timezone"

  after_save :make_fake_ad

  #Do stuff
  def age
  end

  def make_fake_ad
    ad = advertisements.build()
    ad.image = 'rails.png'
    ad.board = self
    ad.user = User.find_by_id(user_id) #current_user @advertisement.image = @advertisement.image_contents.read()
    ad.x_location = 0
    ad.y_location = 0
    ad.width = 1
    ad.height = 1
  end

end
