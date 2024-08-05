class Group < ApplicationRecord
  has_one_attached :group_image

  has_many :group_manbers, dependent: :destroy
  has_many :users, through: :group_menbers
  belongs_to :owner, class_name: "User"

  validates :title, presence: true
  validates :introduction, length: {maximum: 1000}
  
  def get_image(width, height)
    (group_image.attached?) ? group_image : 'no_image.jpg'
    group_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def is_owned_by?(user)
    owner_id == user.id
  end
end
