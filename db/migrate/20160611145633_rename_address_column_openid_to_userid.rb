class RenameAddressColumnOpenidToUserid < ActiveRecord::Migration
  def change
    rename_column :addresses, :openid, :userid
  end
end
