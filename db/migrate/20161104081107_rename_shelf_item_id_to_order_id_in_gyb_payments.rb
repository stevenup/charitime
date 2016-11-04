class RenameShelfItemIdToOrderIdInGybPayments < ActiveRecord::Migration
  def change
    rename_column :gyb_payments, :shelf_item_id, :order_id
  end
end
