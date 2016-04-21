class User < ActiveRecord::Base
  has_many :supports
  has_many :projects, through: :supports
  has_many :donation_records
end
