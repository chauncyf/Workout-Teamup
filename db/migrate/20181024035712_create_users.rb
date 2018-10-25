class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :passwrod_digest
      t.string :email
      t.string :potrait_url
      t.float :height
      t.float :weight
      t.text :physical_condition
      t.text :motto

      t.timestamps
    end
  end
end
