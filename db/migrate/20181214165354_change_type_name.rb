class ChangeTypeName < ActiveRecord::Migration[5.2]
  def change
    rename_column :activity_types, :type, :type_index
  end
end
