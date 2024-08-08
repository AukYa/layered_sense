class Group < ApplicationRecord
  has_one_attached :group_image

  has_many :memberships, dependent: :destroy
  has_many :works
  has_many :users, through: :memberships
  has_many :chats, dependent: :destroy
  belongs_to :owner, class_name: "User"

  validates :title, presence: true
  validates :introduction, length: {maximum: 1000}

  def get_image(width, height)
    if group_image.attached?
      group_image.variant(resize_to_limit: [width, height]).processed
    else
      'no_image.jpg'
    end

  end

  def is_owned_by?(user)
    owner_id == user.id
  end
  
  def includesUser?(user)
    memberships.where(user_id: user.id).exists?
  end
  
  def self.looks(search, word)
      if search == "perfect_match"
        @group = Group.where("title LIKE?", "#{word}")
      elsif search == "foward_macth"
        @group = Group.where("title LIKE?", "#{word}%")
      elsif search == "backward_match"
        @group = Group.where("title LIKE?", "%#{word}")
      elsif search == "partial_match"
        @group = Group.where("title LIKE?", "%#{word}%")
      else
        @group = Group.all
      end
    end
end
