class CreateGybs < ActiveRecord::Migration
  def change
    create_table :gybs do |t|
      t.string :title
      t.integer :type
      t.string :exchange_code
      t.integer :price
      t.string :stock
      t.datetime :expiration_time

      t.timestamps null: false
    end
  end
end
