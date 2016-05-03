class ModifyProjectColumnName < ActiveRecord::Migration
  def change
    rename_column(:projects, :support_type_id, :support_id)
  end
end
