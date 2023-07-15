class UsersController < ApplicationController
  def index
    friend_requests = current_user.friend_requests

    @users = User.all
    @friend_requester_ids = friend_requests.pluck(:friend_id)
    @friend_ids = current_user.friend_ids
    @friend_request_recipient_ids = FriendRequest.all.where(friend_id: current_user.id).pluck(:user_id)
  end

  def show
    user_id = params[:id] ||= current_user.id
    @user = User.find(user_id)
    @user_details = {
      biography: @user.biography,
      real_name: @user.real_name,
      country: @user.country,
      state: @user.state,
      city: @user.city
    }
    @posts = @user.posts.order(created_at: :desc)
  end
end
