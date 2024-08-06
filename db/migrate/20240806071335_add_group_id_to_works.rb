class AddGroupIdToWorks < ActiveRecord::Migration[6.1]
  def change
    add_column :works, :group_id, :integer
  end
end
