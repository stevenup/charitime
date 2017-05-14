class AddPurposeToProductAndShelfItem < ActiveRecord::Migration
  def change
    add_column :products, :purpose, :string
    add_column :shelf_items, :purpose, :string
  end
end
