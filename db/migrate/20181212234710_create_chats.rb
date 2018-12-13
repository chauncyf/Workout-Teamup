class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :send_from
      t.integer :send_to
      t.string :content
      t.integer :status

      t.timestamps
    end
  end
end
