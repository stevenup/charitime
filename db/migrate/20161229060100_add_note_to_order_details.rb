class AddNoteToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :note, :string
  end
end
