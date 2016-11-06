class RenameOrderIdToOrderDetailIdInSupports < ActiveRecord::Migration
  def change
    rename_column :supports, :order_id, :order_detail_id
  end
end
