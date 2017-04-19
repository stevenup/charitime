class AddStatusToSupports < ActiveRecord::Migration
  def change
    add_column :supports, :status, :string, :default => '0'
  end
end
