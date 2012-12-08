class PaymentDetail < ActiveRecord::Base

  attr_accessible :amount
  attr_protected :payable_type, :payable_id, :user_id

  belongs_to :payable, polymorphic: true
  belongs_to :user

  validates :amount, presence: true, numericality: true
end