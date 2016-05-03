class AddProductReferenceToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :product_id, :string
  end
end
