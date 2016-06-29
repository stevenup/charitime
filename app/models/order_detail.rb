class OrderDetail < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  has_many :products
end
