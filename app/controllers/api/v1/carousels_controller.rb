class Api::V1::CarouselsController < ApplicationController
  def index
    carousels = Carousel.where('is_published = ?', '1').last(3)
    render json: carousels, status: :ok
  end
end