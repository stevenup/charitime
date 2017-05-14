class AddShelfItemIdToSupport < ActiveRecord::Migration
  def change
    add_column :supports, :shelf_item_id, :string
  end
end