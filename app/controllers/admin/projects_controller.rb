class Admin::ProjectsController < Admin::AuthenticatedController
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
    @project               = Project.find params[:id]
    @not_linked_items      = ShelfItem.where(project_id: '')
    @items_of_this_project = ShelfItem.where("project_id = ?", params[:id])
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

  def preview
    id = params[:id]
    @project = Project.find_by_project_id(id)
    render layout: 'application'
  end

  def publish
    id = params[:id]
    project = Project.find_by_project_id(id)
    if project
      project.update_attribute(:is_published, '1')
      redirect_to admin_projects_path
    end
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
    ##################################################
    # Still remains lots of problems in this action. #
    ##################################################

    shelf_item_ids = params[:project][:shelf_item_ids]
    if id == 0
      project = Project.new data.except(:shelf_item_ids)
      project.project_id = generate_unique_id
      shelf_item_ids.each do |_id|
        if _id[1] != ''
          shelf_item = ShelfItem.find_by(:id => _id[1])
          # binding.pry
          shelf_item.project_id = data[:project_id] if shelf_item
          shelf_item.save if shelf_item
        end
      end
      redirect_to admin_projects_path if project.save
    else
      project = Project.find(id)
      shelf_item_ids.each do |_id|
        if _id[1] != ''
          shelf_item = ShelfItem.find_by(:id => _id[1])
          shelf_item.update_attribute(:project_id, project.project_id)
        end
      end
      redirect_to admin_projects_path if project.update_attributes data.except(:shelf_item_ids)
    end
  end

  def generate_unique_id
    'P1' + SecureRandom.random_number(999999).to_s
  end

  def project_params
    params.require(:project).permit(:project_name, :category, :banner, :main_pic, :thumb, :project_type_id, :goal,
                                    :project_detail, :support_type_id, shelf_item_ids: [:shelf_item_id_1, :shelf_item_id_2, :shelf_item_id_3])
  end
end