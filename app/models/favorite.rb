class Favorite < ApplicationRecord
  belongs_to :work
  belongs_to :user
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :work_id, uniqueness: {scope: :user_id}

  after_create do
    create_notification(user_id: work.user_id)
  end
end
