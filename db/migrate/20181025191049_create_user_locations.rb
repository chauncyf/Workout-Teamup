class CreateUserLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_locations do |t|
      t.integer :user_id
      t.float :latitude
      t.float :longitude
      t.integer :status

      t.timestamps
    end
  end
end
