class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def detail
    @product = Product.find_by(:id => params[:id])
  end
end
