class ChangeIntegerToFloat < ActiveRecord::Migration
  def change
    change_column :orders, :total_price, :float
    change_column :order_details, :price, :float
    change_column :order_details, :gyb_discount, :float
    change_column :shelf_items,   :price, :float
    change_column :shelf_items,   :gyb_discount, :float
  end
end
