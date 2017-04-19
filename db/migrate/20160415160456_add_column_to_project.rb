class AddColumnToProject < ActiveRecord::Migration
  def change
    add_column :projects, :recommended, :string, :limit => 1
  end
end
