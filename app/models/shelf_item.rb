class ShelfItem < ActiveRecord::Base
  # self.primary_key= 'shelf_item_id'
  belongs_to :product
  belongs_to :order_detail

  belongs_to :project

  mount_uploader :thumb, ShelfItemThumbUploader
end
