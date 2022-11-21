class UsersController < ApplicationController
  def index
    friend_requests = current_user.friend_requests

    @users = User.all
    @friend_requester_ids = friend_requests.pluck(:friend_id)
  end

  def show
  end
end
