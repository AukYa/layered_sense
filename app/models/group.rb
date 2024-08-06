class Group < ApplicationRecord
  has_one_attached :group_image

  has_many :group_manbers, dependent: :destroy
  has_many :works
  has_many :users, through: :group_menbers
  has_many :comments, dependent: :destroy
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
end
