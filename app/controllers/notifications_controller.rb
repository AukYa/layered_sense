class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    case notification.notifiable_type
    when "Work", "Favorite" then
      redirect_to work_path(notification.notifiable.work)
    when "Answer" then
      redirect_to question_path(notification.notifiable.question)
    else
      redirect_to user_path(notification.notifiable)
    end
  end
end
