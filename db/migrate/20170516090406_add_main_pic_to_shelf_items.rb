class AddMainPicToShelfItems < ActiveRecord::Migration
  def change
    add_column :shelf_items, :main_pic, :string
  end
end
