class DonationRecord < ActiveRecord::Base
  belongs_to :admin
  belongs_to :user
end
