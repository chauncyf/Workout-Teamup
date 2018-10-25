class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.integer :activity_id
      t.integer :user_id
      t.string :photo_url

      t.timestamps
    end
  end
end
