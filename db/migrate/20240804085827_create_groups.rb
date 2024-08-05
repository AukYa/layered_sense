class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :title, null: false
      t.text :introduction
      t.integer :owner_id, foreign_key: true

      t.timestamps
    end
  end
end
