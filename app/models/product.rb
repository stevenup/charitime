class Product < ActiveRecord::Base
  belongs_to :product_category
  has_many :product_labels

  has_and_belongs_to_many :projects
end