class ShelfItem < ActiveRecord::Base
  mount_uploader :thumb, ShelfItemThumbUploader
end
