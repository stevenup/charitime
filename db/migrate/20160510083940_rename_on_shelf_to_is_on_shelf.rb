class RenameOnShelfToIsOnShelf < ActiveRecord::Migration
  def change
    rename_column :products, :on_shelf, :is_on_shelf
  end
end
