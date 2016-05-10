class AddOnShelfToProducts < ActiveRecord::Migration
  def change
    add_column :products, :on_shelf, :string, :limit => 1
  end
end
