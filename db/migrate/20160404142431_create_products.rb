class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_id
      t.string :project_id
      t.string :product_name
      t.string :product_price
      t.string :product_category_id
      t.string :product_label_id
      t.string :gyb_discount
      t.string :product_detail
    end
  end
end
