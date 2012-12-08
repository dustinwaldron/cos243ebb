class Board < ActiveRecord::Base
  attr_accessible :height, :name, :timezone, :width
  attr_protected :user_id

  validates :height, presence: true, :numericality => {:only_integer => true, greater_than: 0}
  validates :width, presence: true,:numericality => {:only_integer => true, greater_than: 0 }

  belongs_to :user
  has_many :tiles, :through => :advertisements
  has_many :advertisements
  has_one :payment_detail, :as => :payable

  validates :name, presence: true, length: {minimum: 1}
  validates :width, presence: true, :numericality => { :only_integer => true, greater_than_or_equal_to: 1}
  validates :height, presence: true, :numericality => { :only_integer => true, greater_than_or_equal_to: 1}
  validates :timezone, presence: true
  validates_inclusion_of :timezone, in: ActiveSupport::TimeZone.zones_map { |m| m.name }, message: "is not a valid Timezone"

  before_create :make_fake_ad
  #before_create :make_payment_detail

  #Do stuff
  def age
  end

  def make_fake_ad
    ad = advertisements.build(:image => 'rails.png', :x_location => 0, :y_location => 0, :width => width, :height => height)
    ad.user = user
    pd = create_payment_detail(:amount => width*height)
    pd.user = user
  end

  def make_payment_detail
    pd = create_payment_detail(:amount => width*height)
    pd.user = user
  end

end
