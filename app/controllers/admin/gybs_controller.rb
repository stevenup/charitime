class Admin::GybsController < Admin::BaseController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  def edit
    @gyb = Gyb.find params[:id]
  end

  def create
    create_or_update gyb_params
  end

  def update
    create_or_update params[:id], gyb_params
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

    @total_rows = Gyb.count(search_obj)
    @rows = Gyb.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])
  end

  def create_or_update(id = 0, data)
    if id == 0
      gyb = Gyb.new data
      redirect_to admin_gybs_path if gyb.save
    else
      gyb = Gyb.find(id)
      redirect_to admin_gybs_path if gyb.update_attributes data
    end
  end

  def gyb_params
    params.require(:gyb).permit(:title, :type, :exchange_code, :price, :stock, :expiration_time)
  end
end