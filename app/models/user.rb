class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :works, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_manbers, dependent: :destroy
  has_many :groups, through: :group_menbers
  
  validates :name, presence: true, length: {maximum: 24}
  validates :introduction, length: {maximum: 1000}

  GUEST_USER_EMAIL = "guest@example.com"

    def self.guest
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        user.password = SecureRandom.urlsafe_base64
        user.name = "guestuser"
      end
    end

    def guest_user?
      email == GUEST_USER_EMAIL
    end

    def get_profile_image(width, height)
      unless profile_image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      profile_image.variant(resize_to_limit: [width, height]).processed
    end

    def self.looks(search, word)
      if search == "perfect_match"
        @user = User.where("name LIKE?", "#{word}")
      elsif search == "foward_macth"
        @user = User.where("name LIKE?", "#{word}%")
      elsif search == "backward_match"
        @user = User.where("name LIKE?", "%#{word}")
      elsif search == "partial_match"
        @user = User.where("name LIKE?", "%#{word}%")
      else
        @user = User.all
      end
    end
end
