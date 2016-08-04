class ProjectsShelfItemsTable < ActiveRecord::Migration
  def change
    create_table :projects_shelf_items, id: false do |t|
      t.belongs_to :project
      t.belongs_to :shelf_item
    end
  end
end
