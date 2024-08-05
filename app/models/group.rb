class Group < ApplicationRecord
  has_one_attached :group_image

  has_many :group_manbers, dependent: :destroy
  has_many :users, through: :group_menbers
  belongs_to :owner, class_name: "User"

  validates :title, presence: true
  validates :introduction, length: {maximum: 1000}
end
