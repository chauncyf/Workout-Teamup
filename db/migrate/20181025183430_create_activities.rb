class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :title
      t.text :content
      t.integer :status
      t.integer :starter_id

      t.timestamps
    end
  end
end
