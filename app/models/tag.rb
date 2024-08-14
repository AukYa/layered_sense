class Tag < ApplicationRecord
  has_many :tag_relationships, dependent: :destroy
  has_many :works, through: :tag_relationships
  
  validates :tag_name, uniqueness: true, presence: true, length: {maximum: 64}
  
  def self.looks(search, word)
      if search == "perfect_match"
        @tag = Tag.where("tag_name LIKE?", "#{word}")
      elsif search == "foward_macth"
        @tag = Tag.where("tag_name LIKE?", "#{word}%")
      elsif search == "backward_match"
        @tag = Tag.where("tag_name LIKE?", "%#{word}")
      elsif search == "partial_match"
        @tag = Tag.where("tag_name LIKE?", "%#{word}%")
      else
        @tags = Tag.all
      end
    end
end
