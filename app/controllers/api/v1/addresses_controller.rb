class Api::V1::AddressesController < ApplicationController
  def get_addresses
    user_id = params[:user_id]
    addresses = Address.where('user_id = ?', user_id)
    addresses.each do |ele|
      ele.province = ChinaCity.get(ele.province)
      ele.city     = ChinaCity.get(ele.city)
      ele.district = ChinaCity.get(ele.district)
    end
    render json: addresses, status: :ok if addresses
  end
end