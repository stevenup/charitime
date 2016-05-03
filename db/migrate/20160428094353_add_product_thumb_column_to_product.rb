class AddProductThumbColumnToProduct < ActiveRecord::Migration
  def change
    add_column :products, :thumb, :string
  end
end
