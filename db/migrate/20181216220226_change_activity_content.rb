class ChangeActivityContent < ActiveRecord::Migration[5.2]
  def change
    remove_column :activity_contents, :customize_sport
    remove_column :activity_contents, :quantity
    remove_column :activity_contents, :duration
    remove_column :activity_contents, :dur_unit
    remove_column :activity_contents, :equipment
    remove_column :activity_contents, :suggestion
    remove_column :activity_contents, :alert
    remove_column :activity_contents, :strength
    rename_column :activity_contents, :quan_unit, :quantity
  end
end
