class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.string :order_detail_id
      t.string :order_id
      t.string :product_id
      t.string :product_price
      t.integer :count
      t.string :remark

      t.timestamps null: false
    end
  end
end
