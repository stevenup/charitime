class DropTableSupportType < ActiveRecord::Migration
  def change
    drop_table :support_types
  end
end
