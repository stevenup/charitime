class Order < ActiveRecord::Base
  self.primary_key= 'order_id'
  belongs_to :user
  has_many :order_details, dependent: :destroy

  enum order_status: { REFUND_REJECTED: -5, REFUNDING: -4, REFUNDED: -3, CANCELED: -2, FAILED: -1, UNPAID: 0, PAID: 1 }

  # logistics_status default => 0, so the UNDELIVERED status is implicit.
  # Because it is equivalent to the condition that order_status = 1 AND logistics_status = 0
  enum logistics_status: { DELIVERED: 3, COMPLETED: 4 }
end
