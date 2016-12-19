class HomeController < BaseController
  def index
    @recommended_items = ShelfItem.where("recommended = '1'").order("updated_at DESC")
    @projects          = Project.where("is_published = ?", '1').order("updated_at DESC")
    @carousels         = Carousel.where('is_published = ?', '1').order('updated_at DESC').first(3)
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
