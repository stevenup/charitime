class Support < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  belongs_to :support_type
end
