class Question < ApplicationRecord
  has_one_attached :attachments_file

  belongs_to :user, optional: true

  has_many :answers, dependent: :destroy

  validates :title, length: {maximum: 64}, presence: true
  validates :content, length: {maximum: 1000}

# view_contextとすることでviewとして渡している
  def attachments_type?(view_context)
    if attachments_file.attached?
        tmp_file_url = Rails.application.routes.url_helpers.rails_blob_path(attachments_file, only_path: true)
        check_ext = File.extname(tmp_file_url).downcase

        # 音声として許可する拡張子
        audio_ext_list = [
          '.wav',
          '.mp3'
        ]
      # 音声
      if audio_ext_list.include?(check_ext)
        view_context.audio_tag(view_context.polymorphic_path(attachments_file), controls: true)
      else
        # 画像
        view_context.image_tag(view_context.polymorphic_path(attachments_file), controls: true)
      end
    end
  end

  def self.looks(search, word)
      if search == "perfect_match"
        @question = Question.where("title LIKE?", "#{word}")
      elsif search == "foward_macth"
        @question = Question.where("title LIKE?", "#{word}%")
      elsif search == "backward_match"
        @question = Question.where("title LIKE?", "%#{word}")
      elsif search == "partial_match"
        @question = Question.where("title LIKE?", "%#{word}%")
      else
        @questions = Question.all
      end
    end
end
