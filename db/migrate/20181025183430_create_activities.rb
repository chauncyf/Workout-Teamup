class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.datetime :activity_date
      t.string :place
      t.text :content
      t.integer :starter_id
      t.integer :status

      t.timestamps
    end
  end
end
