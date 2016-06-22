class Order < ActiveRecord::Base
  self.primary_key= 'order_id'
  belongs_to :user
  has_many :order_details, dependent: :destroy
end