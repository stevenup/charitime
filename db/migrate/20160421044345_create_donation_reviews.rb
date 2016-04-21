class CreateDonationReviews < ActiveRecord::Migration
  def change
    create_table :donation_reviews do |t|
      t.string :admin_id

      t.timestamps null: false
    end
  end
end
