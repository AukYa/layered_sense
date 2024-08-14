class Question < ApplicationRecord
  has_one_attached :attachments_file
  
  belongs_to :user, optional: true
  
  has_many :answers, dependent: :destroy
  
  validates :title, length: {maximum: 64}, presence: true
  validates :content, length: {maximum: 1000}
  
  def self.looks(search, word)
      if search == "perfect_match"
        @question = Question.where("title LIKE?", "#{word}")
      elsif search == "foward_macth"
        @question = Question.where("title LIKE?", "#{word}%")
      elsif search == "backward_match"
        @question = Question.where("title LIKE?", "%#{word}")
      elsif search == "partial_match"
        @question = Question.where("title LIKE?", "%#{word}%")
      else
        @questions = Question.all
      end
    end
end
