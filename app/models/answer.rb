class Answer < ApplicationRecord
  has_one_attached :attachments_file
  
  belongs_to :question
  belongs_to :user, optional: true
  
  validates :content, length: {maximum: 1000}, presence: true
  validates :is_best_answer, inclusion: [true, false]
end
