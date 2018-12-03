class CreateActivityParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_participants do |t|
      t.integer :user_id
      t.integer :activity_id
      t.integer :identity
      t.integer :rating
      t.timestamps
    end
  end
end
