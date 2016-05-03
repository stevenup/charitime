class CreateDonationRecords < ActiveRecord::Migration
  def change
    create_table :donation_records do |t|
      t.string :donation_record_id
      t.string :openid

      t.timestamps null: false
    end
  end
end
