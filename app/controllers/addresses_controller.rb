class AddressesController < BaseController
  def index
    @addresses = Address.where :user_id => current_user.id
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
    # The params province, city and district, are not submitted together with the hash from the form.
    # So they need to be received alone.
    province = params[:province]
    city     = params[:city]
    district = params[:district]

    if id == 0
      data[:province] = ChinaCity.get province
      data[:city]     = ChinaCity.get city
      data[:district] = ChinaCity.get district
      address         = Address.new data
      address.user_id = current_user.id
      address.default = '1' if Address.where(user_id: current_user.id).count == 0
      redirect_to addresses_path if address.save
    else
      address = Address.find(id)
      data[:province] = ChinaCity.get province
      data[:city]     = ChinaCity.get city
      data[:district] = ChinaCity.get district
      redirect_to addresses_path if address.update_attributes data
    end
  end

  def address_params
    params.require(:address).permit(:receiver_name, :province, :city, :district, :detail_address, :mobile)
  end
end
