class ChangeProductDetailType < ActiveRecord::Migration
  def change
    change_column :products, :product_detail, :text
    change_column :shelf_items, :product_detail, :text
  end
end
