class AddressesController < BaseController
  def index
    @addresses = Address.where(:user_id => current_user.id.to_s).order('created_at DESC')
    if @addresses != []
      @addresses.each do |ele|
        Address.convert_addr(ele)
      end
    end
  end

  def new
    @address = Address.new
    render partial: 'form'
  end

  def edit
    @address = Address.find_by_id params[:id]
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
    address  = Address.find_by_id(params[:id])
    if address
      _address = Address.find_by(:user_id => current_user.id.to_s, :default => 1)
      _address.update_attribute(:default, 0) if _address
      redirect_to addresses_path if address.update_attribute(:default, 1)
    else
      Rails.logger.info '****************************************************** ********************'
      Rails.logger.info '******************** error in setting default address. ********************'
      Rails.logger.info '****************************************************** ********************'
      redirect_to addresses_path
    end
  end

  private
  def create_or_update(id = 0, data)
    if id == 0
      address_data    = wrap_address(data)
      address         = Address.new address_data
      address.user_id = current_user.id.to_s
      redirect_to :back if address.save
    else
      address         = Address.find_by_id(id)
      address_data    = wrap_address(data)
      redirect_to :back if address.update_attributes address_data
    end
  end

  def wrap_address(data)
    address_data                  = Hash.new
    address_data[:province]       = data[:province]
    address_data[:city]           = data[:city]
    address_data[:district]       = data[:district]
    address_data[:receiver_name]  = data[:address][:receiver_name]
    address_data[:mobile]         = data[:address][:mobile]
    address_data[:detail_address] = data[:address][:detail_address]
    address_data
  end

  def address_params
    params.permit(:id, :province, :city, :district, address: [:receiver_name, :mobile, :detail_address])
  end
end
