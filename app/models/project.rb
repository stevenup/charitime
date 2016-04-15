class Project < ActiveRecord::Base
  belongs_to :project_type

  has_many :supports
  has_many :users, through: :supports

  has_and_belongs_to_many :products
end