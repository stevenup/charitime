class ChangePriceTypeToInteger < ActiveRecord::Migration
  def change
    change_column :orders, :total_price, :integer
    change_column :order_details, :price, :integer
    change_column :order_details, :gyb_discount, :integer
  end
end
