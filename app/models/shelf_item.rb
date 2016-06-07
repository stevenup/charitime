class ShelfItem < ActiveRecord::Base
  belongs_to :product

  mount_uploader :thumb, ShelfItemThumbUploader
end
