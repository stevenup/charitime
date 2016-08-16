class HomeController < BaseController
  before_action :auth_user, only: [:index]

  def index
    @recommended_products = ShelfItem.where "recommended = '1'"
    @projects = Project.all.order(created_at: :desc)
  end

  def personal_center
    @user = current_user
  end

  def donations_center
  end

  def my_gyb
    @user = current_user
  end

  def project_detail
  end

  def product_detail
  end

  def donate_page
  end

  def my_address
  end

  def exchange
    exchange_code = params[:exchange_code]
    puts '>>>>>>>>'
    puts exchange_code
  end

end
