class Admin::ProjectsController < Admin::BaseController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find params[:id]
  end

  def create
    create_or_update project_params
  end

  def update
    create_or_update params[:id], project_params
  end

  def destroy
    project = Project.find params[:id]
    redirect_to admin_projects_path if project.destroy
  end

  private
  def get_rows
    dt = decode_datatables_params

    where_array = []

    search_obj = {
        :include => [],
        :joins => [],
        :order => dt[:sort_statement],
        :conditions => [where_array.join(' AND ')]
    }

    @total_rows = Project.count(search_obj)
    @rows = Project.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])
  end

  def create_or_update(id = 0, data)
    shelf_item_ids = params[:project][:shelf_item_ids]
    id1 = shelf_item_ids[:shelf_item_id_1]
    id2 = shelf_item_ids[:shelf_item_id_2]
    puts '>>>>>>'
    puts id1
    puts id2
    if id == 0
      project = Project.new data.except(:shelf_item_ids)
      shelf_item_ids.each do |_id|
        shelf_item = ShelfItem.find_by(:id => _id)
        shelf_item.project_id = data[:project_id] if shelf_item
        shelf_item.save
      end
      redirect_to admin_projects_path if project.save
    else
      project = Project.find(id)
      shelf_item_ids.each do |_id|
        shelf_item = ShelfItem.find_by(:id => _id)
        shelf_item.update_attribute(:project_id, data[:project_id])
      end
      redirect_to admin_projects_path if project.update_attributes data.except(:shelf_item_ids)
    end
  end

  def project_params
    params.require(:project).permit(:project_id, :project_name, :banner, :main_pic, :thumb, :project_type_id, :project_detail,
                                    :support_type_id, shelf_item_ids: [:shelf_item_id_1, :shelf_item_id_2])
  end
end