class ChangeActivity < ActiveRecord::Migration[5.2]
  def change
    remove_column :activities, :theme_color
    remove_column :activities, :type
    add_column :activities, :activity_type_id, :integer

  end
end
