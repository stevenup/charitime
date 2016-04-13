class Admin::SupportTypesController < Admin::BaseController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  def new
    @support_type = SupportType.new
  end

  def edit
    @support_type = SupportType.find params[:id]
  end

  def create
    create_or_update support_type_params
  end

  def update
    create_or_update params[:id], support_type_params
  end

  def destroy
    support_type = SupportType.find params[:id]
    redirect_to admin_support_types_path if support_type.destroy
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

    @total_rows = SupportType.count(search_obj)
    @rows = SupportType.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])
  end

  def create_or_update(id = 0, data)
    if id == 0
      support_type = SupportType.new data
      redirect_to admin_support_types_path if support_type.save
    else
      support_type = SupportType.find(id)
      redirect_to admin_support_types_path if support_type.update_attributes data
    end
  end

  def support_type_params
    params.require(:support_type).permit(:support_type_name )
  end
end