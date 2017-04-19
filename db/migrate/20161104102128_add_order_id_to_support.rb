class AddOrderIdToSupport < ActiveRecord::Migration
  def change
    add_column :supports, :order_id, :string
  end
end
