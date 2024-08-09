class Chat < ApplicationRecord
  belongs_to :group
  belongs_to :user
  
  validates :chat, presence: true, length: {maximum: 1000}
end
