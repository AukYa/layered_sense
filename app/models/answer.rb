class Answer < ApplicationRecord
  has_one_attached :attachments_file
  
  belongs_to :question
  belongs_to :user, optional: true
  has_one :notification, as: :notifiable, dependent: :destroy
  
  validates :content, length: {maximum: 1000}, presence: true
  validates :is_best_answer, inclusion: [true, false]
  
  after_create do
    create_notification(user_id: question.user_id)
  end
end
