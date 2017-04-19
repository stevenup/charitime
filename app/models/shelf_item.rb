class ShelfItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :project

  has_many :order_details

  mount_uploader :thumb, ShelfItemThumbUploader
end
