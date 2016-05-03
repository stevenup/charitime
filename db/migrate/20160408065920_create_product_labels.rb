class CreateProductLabels < ActiveRecord::Migration
  def change
    create_table :product_labels do |t|
      t.string :product_label_name

      t.timestamps null: false
    end
  end
end
