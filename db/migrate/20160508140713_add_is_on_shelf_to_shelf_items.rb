class AddIsOnShelfToShelfItems < ActiveRecord::Migration
  def change
    add_column :shelf_items, :is_on_shelf, :string, :limit => 1
  end
end
