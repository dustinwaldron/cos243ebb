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

end
