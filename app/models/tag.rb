class Tag < ApplicationRecord
  has_many :works, through: :tag_relationships
  has_many :tag_relationships, dependent: :destroy
  validates :name, uniqueness: true
end
