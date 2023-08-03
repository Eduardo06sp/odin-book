class UsersController < ApplicationController
  def index
    friend_requests = current_user.friend_requests

    @users = User.all.with_attached_avatar
    @friend_requester_ids = friend_requests.pluck(:friend_id)
    @friend_ids = current_user.friend_ids
    @friend_request_recipient_ids = FriendRequest.all.where(friend_id: current_user.id).pluck(:user_id)
  end

  def show
    user_id = params[:id] ||= current_user.id
    @user = User.find(user_id)
    @user_details = @user.profile_details
    @posts = @user
      .posts
      .includes(
        :liking_users,
        :comments
      )
      .with_attached_image
      .order(created_at: :desc)
  end
end
