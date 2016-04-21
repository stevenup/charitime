class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :donation_record_id
      t.string :donation_id
      t.string :donation_name
      t.string :donation_category_id
      t.string :donation_description
      t.integer :gyb
      t.string :estimated_value
      t.string :donation_state_id
      t.string :donation_review_id
      t.string :logistics_company
      t.string :delivery_num

      t.timestamps null: false
    end
  end
end
