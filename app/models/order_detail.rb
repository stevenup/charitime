class OrderDetail < ActiveRecord::Base
  # self.primary_key= 'order_detail_id'

  belongs_to :order
  belongs_to :user

  has_one :support

  belongs_to :shelf_item, foreign_key: 'shelf_item_id'
end
