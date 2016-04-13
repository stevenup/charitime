class Admin::UsersController < Admin::BaseController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
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

    @total_rows = User.count(search_obj)
    @rows = User.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])
  end

  def users_params
    params.require(:users).permit(:openid, :nickname, :mobile, :sex, :country, :city, :province, :headimgurl, :address, :gyb, :other)
  end
end
