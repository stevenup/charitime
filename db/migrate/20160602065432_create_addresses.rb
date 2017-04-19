class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :openid
      t.string :name    # 收货人姓名
      t.string :province
      t.string :city
      t.string :district
      t.string :detail_info
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
