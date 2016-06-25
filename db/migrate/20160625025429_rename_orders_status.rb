class RenameOrdersStatus < ActiveRecord::Migration
  def change
    rename_column :orders, :status, :order_status
  end
end
