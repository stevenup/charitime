class CreateDonationStates < ActiveRecord::Migration
  def change
    create_table :donation_states do |t|
      t.string :name, default: '正在处理中'

      t.timestamps null: false
    end
  end
end
