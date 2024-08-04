class GroupMenber < ApplicationRecord
  belongs_to :users
  belongs_to :groups
  
  validates :group_id, uniqueness: {scope: :user_id}
end
