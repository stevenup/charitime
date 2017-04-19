class Donation < ActiveRecord::Base
  belongs_to :donation_record
  belongs_to :donation_review
  belongs_to :donation_state
end
