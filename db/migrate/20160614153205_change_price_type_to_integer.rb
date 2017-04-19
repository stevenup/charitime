class ChangePriceTypeToInteger < ActiveRecord::Migration
  def change
    change_column :orders, :total_price, 'integer USING CAST(total_price AS integer)'
    change_column :order_details, :price, 'integer USING CAST(price AS integer)'
    change_column :order_details, :gyb_discount, 'integer USING CAST(gyb_discount AS integer)'
  end
end
