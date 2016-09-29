class Support < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  # DEDICATION: 无偿支持； PURCHASE: 购买支持
  enum support_type: { 'DEDICATION': 0, 'PURCHASE': 1 }
end
