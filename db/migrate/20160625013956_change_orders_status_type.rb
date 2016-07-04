class ChangeOrdersStatusType < ActiveRecord::Migration
  def change
    change_column :orders, :status, :integer, null: false
  end
end
