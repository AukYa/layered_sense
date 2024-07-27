class Comment < ApplicationRecord
  belongs_to :work
  belongs_to :user
  
  validates :content, presence: true
end
