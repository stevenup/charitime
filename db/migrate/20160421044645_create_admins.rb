class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :name
      t.string :password
      t.string :auth
      t.string :remarks

      t.timestamps null: false
    end
  end
end
