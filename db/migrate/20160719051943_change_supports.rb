class ChangeSupports < ActiveRecord::Migration
  def change
    rename_column :supports, :openid, :user_id
    add_column :supports, :project_id, :string
    add_column :supports, :type, :string
  end
end
