class Admin::ProjectTypesController < Admin::BaseController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  def new
    @project_type = ProjectType.new
  end

  def edit
    @project_type = ProjectType.find params[:id]
  end

  def create
    create_or_update project_type_params
  end

  def update
    create_or_update params[:id], project_type_params
  end

  def destroy
    project_type = ProjectType.find params[:id]
    redirect_to admin_project_types_path if project_type.destroy
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

    @total_rows = ProjectType.count(search_obj)
    @rows = ProjectType.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])
  end

  def create_or_update(id = 0, data)
    if id == 0
      project_type = ProjectType.new data
      redirect_to admin_project_types_path if project_type.save
    else
      project_type = ProjectType.find(id)
      redirect_to admin_project_types_path if project_type.update_attributes data
    end
  end

  def project_type_params
    params.require(:project_type).permit(:project_type_name )
  end
end