class RenameUseridToUserId < ActiveRecord::Migration
  def change
    rename_column :addresses, :userid, :user_id
  end
end
