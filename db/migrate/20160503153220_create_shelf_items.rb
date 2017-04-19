class CreateShelfItems < ActiveRecord::Migration
  def change
    create_table :shelf_items do |t|
      t.string :product_id
      t.string :project_id
      t.string :product_name
      t.string :product_category_id
      t.string :product_label_id
      t.string :product_detail

      t.integer :price
      t.integer :gyb_discount
      t.integer :stock
      t.integer :sales

      t.timestamps null: false
    end
  end
end
