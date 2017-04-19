class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :openid
      t.string :product_id
      t.integer :product_price
      t.string :count

      t.timestamps null: false
    end
  end
end
