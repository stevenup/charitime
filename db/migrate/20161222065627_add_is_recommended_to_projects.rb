class AddIsRecommendedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :is_recommended, :string, :default => '0'
  end
end
