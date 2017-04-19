class ChangeTransidNameForOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :trans_id, :transaction_id
  end
end
