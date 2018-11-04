class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :activity_id
      t.integer :user_id
      t.text :content
      t.integer :type
      # what is type here supposed to mean?
      t.timestamps
    end
  end
end
