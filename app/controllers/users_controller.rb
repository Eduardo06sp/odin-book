class UsersController < ApplicationController
  def index
    friend_requests = current_user.friend_requests

    @users = User.all
    @friend_requester_ids = friend_requests.pluck(:friend_id)
    @friend_ids = current_user.friend_ids
    @friend_request_recipient_ids = FriendRequest.all.where(friend_id: current_user.id).pluck(:user_id)
  end

  def show
  end
end
