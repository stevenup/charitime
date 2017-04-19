class RenameColumnForAddresses < ActiveRecord::Migration
  def change
    rename_column :addresses, :name, :receiver_name
    rename_column :addresses, :detail_info, :detail_address
    rename_column :addresses, :phone_number, :mobile
  end
end
