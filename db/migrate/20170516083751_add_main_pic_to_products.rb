class AddMainPicToProducts < ActiveRecord::Migration
  def change
    add_column :products, :main_pic, :string
  end
end
