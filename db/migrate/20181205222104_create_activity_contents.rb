class CreateActivityContents < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_contents do |t|
      t.integer :activity_id
      t.string :sport_option
      t.string :customize_sport
      t.float :quantity
      t.string :quan_unit
      t.float :duration
      t.string :dur_unit
      t.string :equipment
      t.integer :strength
      t.text :suggestion
      t.text :alert

      t.timestamps
    end
  end
end
