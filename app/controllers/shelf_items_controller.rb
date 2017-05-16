class ShelfItemsController < BaseController
  def index
    @shelf_items = ShelfItem.where(:is_on_shelf => '1').order('updated_at DESC')
  end

  def show
    @shelf_item = ShelfItem.find_by(:id => params[:id])
    pid         = params[:pid]

    if pid.nil?
      @project = Project.find_by(:project_id => @shelf_item.project_id, :is_published => '1')
    else
      @project = Project.find_by(:project_id => pid, :is_published => '1')
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
      Address.convert_addr(@address)
    end
  end

  def update_order_address
    _addresses = Address.where('user_id = ?', current_user.id.to_s)
    if _addresses != []
      _addresses.each do |_addr|
        Address.convert_addr(_addr)
      end
    end

    respond_to do |format|
      format.js { render :update_order_address, locals: { addresses: _addresses } }
    end
  end
end
