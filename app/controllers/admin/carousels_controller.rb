class Admin::CarouselsController < Admin::AuthenticatedController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  def new
    @carousel = Carousel.new
  end

  def edit
    @carousel = Carousel.find_by(:id => params[:id])
  end

  def create
    create_or_update(carousel_params)
  end

  def update
    create_or_update(params[:id], carousel_params)
  end

  def destroy
    carousel = Carousel.find_by(:id => params[:id])
    redirect_to admin_carousels_path if carousel.destroy
  end

  def publish
    carousel = Carousel.find_by(:id => params[:id])
    redirect_to admin_carousels_path if carousel.update_attribute(:is_published, '1')
  end

  def preview
    @carousel = Carousel.find_by(:id => params[:id])
    if @carousel.is_custom == '1'
      redirect_to @carousel.custom_url
    else
      render layout: 'mobile'
    end
  end

  def depublish
    carousel = Carousel.find_by(:id => params[:id])
    redirect_to admin_carousels_path if carousel.update_attribute(:is_published, '0')
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

    @total_rows = Carousel.count(search_obj)
    @rows = Carousel.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])
  end

  def create_or_update(id = 0, data)
    if id == 0
      if data[:is_custom] == '0'
        carousel = Carousel.new(data.except(:custom_url))
        redirect_to admin_carousels_path if carousel.save
      elsif data[:is_custom] == '1'
        carousel = Carousel.new(data.except(:detail))
        redirect_to admin_carousels_path if carousel.save
      else
        render plain: '出错啦!'
      end
    else
      carousel = Carousel.find_by(:id => id)
      if data[:is_custom] == '0'
        redirect_to admin_carousels_path if carousel.update_attributes data.except(:custom_url)
      elsif data[:is_custom] == '1'
        redirect_to admin_carousels_path if carousel.update_attributes data.except(:detail)
      else
        render plain: '出错啦!'
      end
    end
  end

  def carousel_params
    params.require(:carousel).permit(:title, :image, :is_custom, :custom_url, :detail)
  end
end