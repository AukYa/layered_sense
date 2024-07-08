class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.string :title
      t.text :introduction
      t.integer :user_id
      t.integer :tag_id
      t.timestamps
    end
  end
end
