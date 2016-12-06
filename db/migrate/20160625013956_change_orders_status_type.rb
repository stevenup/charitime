class ChangeOrdersStatusType < ActiveRecord::Migration
  def change
    change_column :orders, :status, 'integer USING CAST(status AS integer)', null: false
  end
end
