class Work < ApplicationRecord
  has_one_attached :music_file
  
  belongs_to :user
  
  validates :music_file, presence: true
  
  def self.looks(search, word)
      if search == "perfect_match"
        @work = Work.where("title LIKE?", "#{word}")
      elsif search == "foward_macth"
        @work = Work.where("title LIKE?", "#{word}%")
      elsif search == "backward_match"
        @work = Work.where("title LIKE?", "%#{word}")
      elsif search == "partial_match"
        @work = Work.where("title LIKE?", "%#{word}%")
      else
        @work = Work.all
      end
    end
end
