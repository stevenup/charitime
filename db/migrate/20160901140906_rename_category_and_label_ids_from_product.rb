class RenameCategoryAndLabelIdsFromProduct < ActiveRecord::Migration
  def change
    rename_column :products, :product_category_id, :category
    rename_column :products, :product_label_id, :label
  end
end
