class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :openid
      t.string :order_id, primary_key: true
      t.string :status
      t.string :total_price
      t.string :trans_id

      t.timestamps null: false
    end
  end
end
