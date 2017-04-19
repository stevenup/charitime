class AddRemarkToGybIncome < ActiveRecord::Migration
  def change
    add_column :gyb_incomes, :remark, :string
  end
end
