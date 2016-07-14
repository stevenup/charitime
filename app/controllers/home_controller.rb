class HomeController < BaseController
  before_action :auth_user, only: [:index]

  def index
    @recommended_products = ShelfItem.where "recommended = '1'"
  end

  def personal_center
    @user = current_user
  end

  def donations_center
  end

  def my_gyb
  end

  def project_detail
  end

  def product_detail
  end

  def donate_page
  end

  def my_address

  end

end
