class AddPrivilegeToUser < ActiveRecord::Migration
  def change
    add_column :users, :privilege, :string, array: true, default: []
  end
end
