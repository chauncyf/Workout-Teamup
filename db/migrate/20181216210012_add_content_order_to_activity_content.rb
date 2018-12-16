class AddContentOrderToActivityContent < ActiveRecord::Migration[5.2]
  def change
    add_column :activity_contents, :content_order, :integer
  end
end
