class Product < ActiveRecord::Base
  mount_uploader :thumb, ProductThumbUploader
  mount_uploader :main_pic, ProductMainPicUploader

  has_one  :shelf_item
  has_many :product_labels
  has_many :order_details
  belongs_to :product_category

  has_and_belongs_to_many :projects, join_table: "products_projects"
end
