class CreateGroupMenbers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_menbers do |t|
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :tag_relationships, [:group_id,:user_id],unique: true
  end
end
