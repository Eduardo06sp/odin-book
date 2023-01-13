class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
  end

  def destroy
    notification = Notification.find(params[:id])

    if notification.destroy
      flash[:notice] = 'Notification removed.'
    else
      flash[:alert] = 'Unable to remove notification.'
    end

    redirect_back_or_to root_path
  end
end
