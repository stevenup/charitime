class CreateLogisticsCompanies < ActiveRecord::Migration
  def change
    create_table :logistics_companies do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
