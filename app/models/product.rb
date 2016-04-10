class Product < ActiveRecord::Base
  belongs_to :product_category
  has_many :product_labels
end