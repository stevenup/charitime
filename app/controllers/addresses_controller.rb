class AddressesController < ApplicationController
  def index
    @addresses = Address.all
  end

  def new
    @address = Address.new
  end

  def edit
    @address = Address.find params[:id]
  end

  def create
    create_or_update address_params
  end

  def update
    create_or_update params[:id], address_params
  end

  private
  def create_or_update(id = 0, data)
    if id == 0
      province =  ChinaCity.get '110117'
      address = Address.new data
      redirect_to addresses_path if address.save
    else
      address = Address.find(id)
      redirect_to addresses_path if address.update_attributes data
    end
  end

  def address_params
    params.require(:address).permit(:openid, :name, :province, :city, :district, :detail_info, :phone_number)
  end
end