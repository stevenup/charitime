class ChangeSupportsAndProjects < ActiveRecord::Migration
  def change
    remove_column :supports, :support_type_id
    remove_column :projects, :support_id
    remove_column :projects, :openid
    rename_column :projects, :product_id, :shelf_item_id
    rename_column :projects, :project_type_id, :type
  end
end
