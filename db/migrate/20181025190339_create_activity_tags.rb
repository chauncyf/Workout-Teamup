class CreateActivityTags < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_tags do |t|
      t.integer :activity_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
