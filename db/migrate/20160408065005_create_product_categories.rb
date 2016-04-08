class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.string :product_category_name

      t.timestamps null: false
    end
  end
end
