class AddIsPublishedToProject < ActiveRecord::Migration
  def change
    add_column :projects, :is_published, :string, :default => '0'
  end
end
