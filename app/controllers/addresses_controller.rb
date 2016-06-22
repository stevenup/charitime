class AddressesController < BaseController
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
      data[:province] = ChinaCity.get data[:province]
      data[:city]     = ChinaCity.get data[:city]
      data[:district] = ChinaCity.get data[:district]
      user_id         = current_user.id
      address         = Address.new data
      address.user_id  = user_id
      redirect_to addresses_path if address.save
    else
      address = Address.find(id)
      data[:province] = ChinaCity.get data[:province]
      data[:city]     = ChinaCity.get data[:city]
      data[:district] = ChinaCity.get data[:district]
      redirect_to addresses_path if address.update_attributes data
    end
  end

  def address_params
    params.require(:address).permit(:openid, :receiver_name, :province, :city, :district, :detail_address, :mobile)
  end
end
