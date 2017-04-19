class RenameProductIdToShelfItemIdInOrderDetail < ActiveRecord::Migration
  def change
    rename_column :order_details, :product_id, :shelf_item_id
  end
end
