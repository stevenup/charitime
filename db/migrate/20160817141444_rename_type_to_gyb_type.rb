class RenameTypeToGybType < ActiveRecord::Migration
  def change
    rename_column :gybs, :type, :gyb_type
  end
end
