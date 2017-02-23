class Api::V1::AddressesController < ApplicationController
  protect_from_forgery with: :null_session

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

  def create_address
    address = Address.new(address_params)
    if address.save
      render json: { result: 'SUCCESS' }, status: :ok
    else
      render json: { result: 'FAILURE' }, status: :ok
    end
  end

  private

    def address_params
      params.require(:address).permit(:user_id, :receiver_name, :mobile, :province, :city, :district, :detail_address, :default)
    end
end