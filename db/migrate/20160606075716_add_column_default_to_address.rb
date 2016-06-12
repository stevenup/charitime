class AddColumnDefaultToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :default, :string, :limit => '1'
  end
end
