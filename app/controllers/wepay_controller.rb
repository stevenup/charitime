class WepayController < ApplicationController
  def unified_order
    id = params[:data]
    product = Product.find_by_id(id)
    params = {
      body:         product.product_name,
      total_fee:    product.
      out_trade_no: product.product_id,
    }
    Wepay::Service.invoke_unifiedorder
  end

  def recv
  end
end
