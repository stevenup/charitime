class AddMainPicToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :main_pic, :string
  end
end
