class AddMoneyToSupports < ActiveRecord::Migration
  def change
    add_column :supports, :money, :float
  end
end
