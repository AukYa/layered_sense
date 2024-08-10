class Favorite < ApplicationRecord
  belongs_to :work
  belongs_to :user
  
  validates :work_id, uniqueness: {scope: :user_id}
end
