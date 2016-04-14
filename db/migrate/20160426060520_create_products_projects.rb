class CreateProductsProjects < ActiveRecord::Migration
  def change
    create_table :products_projects, id: false do |t|
      t.integer :product_id
      t.integer :project_id
    end
  end
end
