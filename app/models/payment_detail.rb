class PaymentDetail < ActiveRecord::Base

  attr_accessible :amount, :payable_type, :payable_id, :user_id

  belongs_to :payable, polymorphic: true
  belongs_to :user
end

# Add to Advertizments has_many :payment_details, as: payable