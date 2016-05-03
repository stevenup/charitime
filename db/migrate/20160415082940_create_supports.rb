class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.string :openid
      t.string :support_type_id

      t.timestamps null: false
    end
  end
end
