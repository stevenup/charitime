class CreateGybPayments < ActiveRecord::Migration
  def change
    create_table :gyb_payments do |t|
      t.string :user_id
      t.string :shelf_item_id

      t.timestamps null: false
    end
  end
end
