class Project < ActiveRecord::Base
  self.primary_key= 'project_id'

  mount_uploader :thumb, ProjectThumbUploader
  mount_uploader :banner, ProjectBannerUploader
  mount_uploader :main_pic, ProjectMainPicUploader

  has_many :supports
  # has_many :users, through: :supports

  has_and_belongs_to_many :shelf_items, foreign_key: 'project_id'

  # enum type: { 'TYPE1': 1, 'TYPE2': 2 }
end
