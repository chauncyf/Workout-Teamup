class CreateGyms < ActiveRecord::Migration[5.2]
  def change
    create_table :gyms do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.text :description

      t.timestamps
    end
  end
end
