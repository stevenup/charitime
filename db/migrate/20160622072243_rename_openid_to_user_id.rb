class RenameOpenidToUserId < ActiveRecord::Migration
  def change
    rename_column :orders, :openid, :user_id
  end
end
