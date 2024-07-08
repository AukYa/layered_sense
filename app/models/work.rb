class Work < ApplicationRecord
  has_one_attached :music_file
  
  belongs_to :user
  
  validates :music_file, presence: true
end
