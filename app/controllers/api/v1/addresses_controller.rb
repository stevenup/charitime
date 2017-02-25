class Api::V1::AddressesController < ApplicationController
  protect_from_forgery with: :null_session

  def get_addresses
    user_id = params[:user_id]
    addresses = Address.where('user_id = ?', user_id)
    addresses.each do |ele|
      ele.province = ChinaCity.get(ele.province) if ele.province
      ele.city     = ChinaCity.get(ele.city)     if ele.city
      # ele.district = ChinaCity.get(ele.district) if ele.district
    end
    render json: addresses, status: :ok if addresses
  end

  def get_address
    id = params[:id]
    address = Address.find_by_id(id)
    render json: address, status: :ok if address
  end

  def create_address
    address = Address.new(address_params)
    if address.save
      render json: { result: 'SUCCESS' }, status: :ok
    else
      render json: { result: 'FAILURE' }, status: :ok
    end
  end

  def set_default
    id = params[:id]
    address = Address.find_by_id(id)
    _address = Address.find_by(:user_id => '123', :default => 1)
    _address.update_attribute(:default, 0) if _address
    if address.update_attribute(:default, 1)
      render json: { result: 'SUCCESS'}
    else
      render json: { result: 'ERROR' }
    end
  end

  def delete_address
    id = params[:id]
    address = Address.find_by_id(id)
    render json: { result: 'SUCCESS' } if address.destroy
  end

  private

    def address_params
      params.require(:address).permit(:user_id, :receiver_name, :mobile, :province, :city, :district, :detail_address, :default)
    end
end