class CreateTagRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_relationships do |t|
      t.references :work, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
    add_index :tag_relationships, [:work_id,:tag_id],unique: true
  end
end
