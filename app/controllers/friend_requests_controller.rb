class FriendRequestsController < ApplicationController
  around_action :complete_friend_request, only: :create

  def create
    user = User.find_by(id: params[:user])
    new_friend_request = user.friend_requests.build(friend_id: current_user.id)

    new_friend_request.save!

    flash[:notice] = 'Sent friend request!'
    redirect_back_or_to root_path
  end

  def destroy
    user = User.find_by(id: params[:user])
    friend = User.find_by(id: params[:friend])
    friend_request = FriendRequest.find_sole_by(user_id: user, friend_id: friend)

    friend_request.destroy

    redirect_back_or_to root_path
  end

  def notify_user
    user = User.find_by(id: params[:user])
    friend = User.find_by(id: params[:friend])

    user.notifications.create!(description:
                                 '<span class="notification_username">'\
                                 "#{friend.email}"\
                                 '</span>'\
                                 ' sent you a friend request.')
  end

  def complete_friend_request
    ActiveRecord::Base.transaction do
      yield
      notify_user
    end
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = 'Unable to send friend request.'
    redirect_back_or_to root_path
  end
end
