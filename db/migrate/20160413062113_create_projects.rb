class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_id
      t.string :project_name
      t.string :project_type_id
      t.string :project_detail
      t.string :openid
      t.string :support_type_id

      t.timestamps null: false
    end
  end
end
