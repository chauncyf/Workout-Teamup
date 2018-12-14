class RemoveStrengthFromActivityContent < ActiveRecord::Migration[5.2]
  def change
    remove_column :activity_contents, :strength, :int
  end
end
