class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.datetime :activity_date
      t.string :place
      t.text :content
      t.integer :starter_id
      t.integer :status
      # 1.not started  2.started 3. finished
      t.timestamps
    end
  end
end
