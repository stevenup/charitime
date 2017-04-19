class CreateCarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
      t.string :title
      t.string :image
      t.string :is_custom, :default => '0'
      t.string :custom_url
      t.string :is_published, :default => '0'
      t.string :detail

      t.timestamps null:false
    end
  end
end
