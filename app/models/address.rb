class Address < ActiveRecord::Base
  belongs_to :user

  def self.convert_addr(addr)
    if addr
      addr.province = ChinaCity.get(addr.province)
      addr.city     = ChinaCity.get(addr.city)
      addr.district = ChinaCity.get(addr.district)
    end
  end
end
