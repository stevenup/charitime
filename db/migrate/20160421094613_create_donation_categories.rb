class CreateDonationCategories < ActiveRecord::Migration
  def change
    create_table :donation_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
