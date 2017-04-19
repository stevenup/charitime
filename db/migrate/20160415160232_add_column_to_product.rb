class AddColumnToProduct < ActiveRecord::Migration
  def change
    add_column :products, :recommended, :string, :limit => 1
  end
end
