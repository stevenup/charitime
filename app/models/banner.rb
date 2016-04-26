class Banner < ActiveRecord::Base
  mount_uploader :image, BannerImageUploader
end
