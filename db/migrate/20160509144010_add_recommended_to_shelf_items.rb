class AddRecommendedToShelfItems < ActiveRecord::Migration
  def change
    add_column :shelf_items, :recommended, :string, :limit => 1
  end
end
