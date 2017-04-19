class AddThumbToOrderDetail < ActiveRecord::Migration
  def change
    add_column :order_details, :thumb, :string
  end
end
