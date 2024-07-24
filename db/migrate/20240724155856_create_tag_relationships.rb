class CreateTagRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_relationships do |t|
      t.references :work, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
