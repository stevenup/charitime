class HomeController < BaseController
  before_action :auth_user, only: [:index]

  def index
    @recommended_items = ShelfItem.where("recommended = '1'").order("updated_at DESC")
    @projects          = Project.where("is_published = ?", '1').order("updated_at DESC")
  end

  def personal_center
    @user = current_user
  end

  def donations_center
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
