class ChangeColumnTypeForGybStock < ActiveRecord::Migration
  def change
    change_column :gybs, :stock, :integer
    change_column :users, :gyb, :integer, :default => '0'
  end
end
