class Comment < ApplicationRecord
  belongs_to :work
  belongs_to :user
  
  has_one_attached :each_file
  
  validates :content, presence: true
end
