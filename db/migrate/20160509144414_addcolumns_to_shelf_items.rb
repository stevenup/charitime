class AddcolumnsToShelfItems < ActiveRecord::Migration
  def change
    add_column :shelf_items, :thumb, :string
  end
end
