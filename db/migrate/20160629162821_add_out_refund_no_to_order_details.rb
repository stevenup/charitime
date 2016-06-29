class AddOutRefundNoToOrderDetails < ActiveRecord::Migration
  def change
    add_column :orders, :out_refund_no, :string
  end
end
