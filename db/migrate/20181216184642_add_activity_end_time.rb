class AddActivityEndTime < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :activity_end_time, :datetime
  end
end
