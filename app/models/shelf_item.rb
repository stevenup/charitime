class ShelfItem < ActiveRecord::Base
  # self.primary_key= 'shelf_item_id'
  belongs_to :product

  has_and_belongs_to_many :projects, dependent: 'destroy', foreign_key: 'shelf_item_id'

  mount_uploader :thumb, ShelfItemThumbUploader
end
