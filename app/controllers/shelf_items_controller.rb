class ShelfItemsController < BaseController
  def index
    @shelf_items = ShelfItem.where(:is_on_shelf => '1').order("updated_at DESC")
  end

  def show
    @shelf_item = ShelfItem.find_by(:id => params[:id])
    pid         = params[:pid]

    if pid.nil?
      @project = Project.find_by_project_id(@shelf_item.project_id)
    else
      @project = Project.find_by_project_id(pid)
    end

    addresses = Address.where(user_id: current_user.id.to_s)
    if addresses != []
      addresses.each do |ele|
        if ele.default == '1'
          @address = ele
          break
        else
          @address = addresses.last
        end
      end
    end

    if @address
      @address.province = ChinaCity.get @address.province
      @address.city     = ChinaCity.get @address.city
      @address.district = ChinaCity.get @address.district
    end
  end

  def update_order_address
    _addresses = Address.where("user_id = ?", current_user.id.to_s)
    if _addresses != []
      _addresses.each do |_addr|
        _addr.province = ChinaCity.get _addr.province
        _addr.city     = ChinaCity.get _addr.city
        _addr.district = ChinaCity.get _addr.district
      end
    end

    respond_to do |format|
      format.js { render :update_order_address, locals: { addresses: _addresses } }
    end
  end
end
