class RenameCategoryAndLabelOfShelfItem < ActiveRecord::Migration
  def change
    rename_column :shelf_items, :product_category_id, :category
    rename_column :shelf_items, :product_label_id, :label
  end
end
