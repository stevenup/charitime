class Project < ActiveRecord::Base
  mount_uploader :banner, ProjectBannerUploader
  mount_uploader :main_pic, ProjectMainPicUploader

  has_many :supports
  # has_many :users, through: :supports

  has_and_belongs_to_many :products, join_table: "products_projects"

  enum type: { 'TYPE1': 1, 'TYPE2': 2}
end