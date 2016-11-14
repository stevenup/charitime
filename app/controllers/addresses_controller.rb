class AddressesController < BaseController
  def index
    @addresses = Address.where :user_id => current_user.id
    if @addresses != []
      @addresses.each do |ele|
        ele.province = ChinaCity.get ele.province
        ele.city     = ChinaCity.get ele.city
        ele.district = ChinaCity.get ele.district
      end
    end
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

  def destroy
    address = Address.find_by_id(params[:id])
    redirect_to :back if address.destroy
  end

  def modify
    @address = Address.find_by_id(params[:id])
    render partial: 'form'
  end

  def set_default
    _address = Address.find_by(:default => 1)
    _address.update_attribute(:default, 0)
    address = Address.find_by_id(params[:id])
    address.update_attribute(:default, 1)
    redirect_to addresses_path
  end

  private
  def create_or_update(id = 0, data)
    province = params[:province]
    city     = params[:city]
    district = params[:district]

    if id == 0
      data[:province] = province
      data[:city]     = city
      data[:district] = district
      address         = Address.new data
      address.user_id = current_user.id
      address.default = '1' if Address.where(user_id: current_user.id).count == 0
      redirect_to :back if address.save
    else
      address         = Address.find(id)
      data[:province] = province
      data[:city]     = city
      data[:district] = district
      redirect_to :back if address.update_attributes data
    end
  end

  def address_params
    params.permit(:receiver_name, :province, :city, :district, :detail_address, :mobile)
  end
end
