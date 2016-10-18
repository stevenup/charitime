class Order < ActiveRecord::Base
  self.primary_key= 'order_id'
  belongs_to :user
  has_many :order_details, dependent: :destroy

  enum order_status: { REFUND_REJECTED: -5, REFUNDING: -4, REFUNDED: -3, CANCELED: -2, FAILED: -1, UNPAID: 0, PAID: 1 }
  enum logistics_status: { UNDELIVERED: 2, DELIVERED: 3, COMPLETED: 4 }
end
