class Admin::BannersController < Admin::AuthenticatedController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  def new
    @banner = Banner.new
  end

  def edit
    @banner = Banner.find_by(params[:id])
  end

  def create
    create_or_update banner_params
  end

  def update
    create_or_update params[:id], banner_params
  end

  def destroy
    banner = Banner.find_by params[:id]
    redirect_to admin_banners_path if banner.destroy
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

    @total_rows = Banner.count(search_obj)
    @rows = Banner.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])
  end

  def create_or_update(id = 0, data)
    if id == 0
      banner = Banner.new data
      redirect_to admin_banners_path if banner.save
    else
      banner = Banner.find_by(id)
      redirect_to admin_banners_path if banner.update_attributes data
    end
  end

  def banner_params
    params.require(:banner).permit(:banner_name, :thumb, :category, :banner_detail)
  end
end