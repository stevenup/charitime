class AddIsCustomAndCustomUrlColumnToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :is_custom, :string, :default => '0'
    add_column :banners, :custom_url, :string
  end
end
