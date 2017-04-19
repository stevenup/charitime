class RenameTypeToSupportType < ActiveRecord::Migration
  def change
    rename_column :supports, :type, :support_type
  end
end
