class RemoveColumnFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :gyb_discount, :string
    remove_column :products, :product_price, :string
  end
end
