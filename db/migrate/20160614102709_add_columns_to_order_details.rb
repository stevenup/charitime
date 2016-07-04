class AddColumnsToOrderDetails < ActiveRecord::Migration
  def change
    [
        {column: 'receiver_name', type: 'string'},
        {column: 'province', type: 'string'},
        {column: 'city', type: 'string'},
        {column: 'district', type: 'string'},
        {column: 'detail_address', type: 'string'},
        {column: 'mobile', type: 'string'},
        {column: 'express_price', type: 'integer'},
        {column: 'product_name', type: 'string'},
        {column: 'delivery_id', type: 'string'},
        {column: 'delivery_company', type: 'string'}
    ].each do |ele|
      add_column :order_details, ele[:column], ele[:type]
    end
  end
end