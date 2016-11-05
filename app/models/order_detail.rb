class OrderDetail < ActiveRecord::Base
  belongs_to :order
  belongs_to :user

  belongs_to :shelf_item, foreign_key: 'shelf_item_id'
end
