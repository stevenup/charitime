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
    if id == 0
      project = Project.new data
      redirect_to admin_projects_path if project.save
    else
      project = Project.find(id)
      redirect_to admin_projects_path if project.update_attributes data
    end
  end

  def project_params
    params.require(:project).permit(:project_id, :project_name, :banner, :main_pic, :project_type_id, :project_detail, :support_type_id)
  end
end
