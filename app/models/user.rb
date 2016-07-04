class User < ActiveRecord::Base
  has_one :cart
  has_many :supports
  has_many :projects, through: :supports
  has_many :donation_records
  has_many :orders
  has_many :addresses
end
