class Work < ApplicationRecord
  has_one_attached :music_file

  belongs_to :user
  belongs_to :group, dependent: :destroy, optional: true
  has_many :tag_relationships, dependent: :destroy
  has_many :tags, through: :tag_relationships
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :music_file, presence: true
  validates :title, length: {maximum: 64}, presence: true
  validates :introduction, length: {maximum: 1000}

  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

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

  def save_tags(savework_tags)
    savework_tags.each do |new_name|
      work_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << work_tag
    end
  end
end
