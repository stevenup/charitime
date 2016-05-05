class AddTagIdListToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tagid_list, :string
  end
end
