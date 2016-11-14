class ShelfItemsController < BaseController
  def index
    @shelf_items = ShelfItem.where(:is_on_shelf => '1').order("updated_at DESC")
  end

  def show
    @shelf_item = ShelfItem.find_by(:id => params[:id])
    pid = params[:pid]
    if pid.nil?
      @project = Project.find_by_project_id(@shelf_item.project_id)
    else
      @project = Project.find_by_project_id(pid)
    end
    @address = Address.find_by({user_id: current_user.id, default: '1'}) # the default value is used to mark the default address
    if @address
      @address.province = ChinaCity.get @address.province
      @address.city     = ChinaCity.get @address.city
      @address.district = ChinaCity.get @address.district
    end
  end
end
