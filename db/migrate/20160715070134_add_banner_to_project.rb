class AddBannerToProject < ActiveRecord::Migration
  def change
    add_column :projects, :banner, :string
  end
end
