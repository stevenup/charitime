class OrderDetail < ActiveRecord::Base
  belongs_to :order
  belongs_to :user

  belongs_to :shelf_item, foreign_key: 'product_id'
end
