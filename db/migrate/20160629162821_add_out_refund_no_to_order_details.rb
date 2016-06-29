class AddOutRefundNoToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :out_refund_no, :string
  end
end
