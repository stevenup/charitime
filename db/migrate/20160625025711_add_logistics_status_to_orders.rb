class AddLogisticsStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :logistics_status, :integer, default: 0, null: false
  end
end
