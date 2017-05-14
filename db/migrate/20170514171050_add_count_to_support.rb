class AddCountToSupport < ActiveRecord::Migration
  def change
    add_column :supports, :count, :integer, :default => 1
  end
end
