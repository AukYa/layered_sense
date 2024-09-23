module NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Work" then
      "フォローしている#{notification.notifiable.user.name}さんが「#{notification.notifiable.work.title}」を投稿しました。"
    when "Answer" then
      "#{notification.notifiable.user.name}さんが、QuestionにAnswerを投稿しました。"
    else
      "投稿した「#{notification.notifiable.work.title}」が#{notification.notifiable.user.name}さんにいいねされました。"
    end
  end
end
