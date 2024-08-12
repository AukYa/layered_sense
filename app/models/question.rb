class Question < ApplicationRecord
  has_one_attached :attachments_file
  
  belongs_to :user, optional: true
  
  has_many :answers, dependent: :destroy
  
  validates :title, length: {maximum: 64}, presence: true
  validates :content, length: {maximum: 1000}
end
