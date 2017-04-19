class AddDefaultValueToProductIsOnShelf < ActiveRecord::Migration
  def change
    change_column :products, :is_on_shelf, :string, :default => '0'
  end
end
