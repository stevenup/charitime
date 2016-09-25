class CreateGybIncomes < ActiveRecord::Migration
  def change
    create_table :gyb_incomes do |t|
      t.string :user_id
      t.string :gyb_id

      t.timestamps null: false
    end
  end
end
