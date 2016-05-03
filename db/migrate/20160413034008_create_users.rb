class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :openid
      t.string  :nickname
      t.string  :mobile
      t.integer :sex, :limit => 1
      t.string  :city
      t.string  :province
      t.string  :country
      t.string  :headimgurl
      t.string  :unionid
      t.string  :groupid
      t.string  :remark
      t.string  :language
      t.integer :subscribe, :limit => 1
      t.string  :subscribe_time

      t.string  :address
      t.integer :gyb
      t.string  :other

      t.timestamps null: false
    end
  end
end
