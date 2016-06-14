class AddColumnAndRenameColumnForOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :gyb_discount, :string
    rename_column :order_details, :product_price, :price
  end
end
