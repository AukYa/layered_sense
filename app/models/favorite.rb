class Favorite < ApplicationRecord
  belongs_to :work
  belongs_to :user
  has_one :notifications, as: :notifiable, dependent: :destroy
  
  validates :work_id, uniqueness: {scope: :user_id}
end
