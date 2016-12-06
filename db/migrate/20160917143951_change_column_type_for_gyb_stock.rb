class ChangeColumnTypeForGybStock < ActiveRecord::Migration
  def change
    change_column :gybs, :stock, 'integer USING CAST(stock AS integer)'
    change_column :users, :gyb, 'integer USING CAST(gyb AS integer)', :default => '0'
  end
end
