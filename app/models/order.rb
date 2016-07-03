class Order < ActiveRecord::Base
  self.primary_key= 'order_id'
  belongs_to :user
  has_many :order_details, dependent: :destroy

  enum order_status: { 'REFUNDING': -3, 'REFUND': -2, 'FAILED': -1, 'UNPAID': 0, 'SUCCESS': 1, 'CANCELLED': 2 }
  enum logistics_status: { 'UNDELIVERED': 0, 'DELIVERED': 1, 'COMPLETED': 2 }
end
