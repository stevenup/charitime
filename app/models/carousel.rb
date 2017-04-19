class Carousel < ActiveRecord::Base
  mount_uploader :image, CarouselImageUploader
end
