class AddStrengthToActivityContent < ActiveRecord::Migration[5.2]
  def change
    add_column :activity_contents, :strength, :integer
  end
end
