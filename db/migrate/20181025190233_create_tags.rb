class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :type
      t.string :color

      t.timestamps
    end
  end
end
