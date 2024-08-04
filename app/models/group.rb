class Group < ApplicationRecord
  has_many :group_manbers, dependent: :destroy
  has_many :users, through: :group_menbers
  
  validates :title, presence: true
  validates :introduction, length: {maximum: 1000}
end
