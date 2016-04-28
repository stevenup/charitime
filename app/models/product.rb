class Product < ActiveRecord::Base
  mount_uploader :thumb, ProductThumbUploader

  belongs_to :product_category
  has_many :product_labels
  has_many :order_details

  has_and_belongs_to_many :projects, join_table: "products_projects"
end