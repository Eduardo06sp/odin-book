class FriendRequestsController < ApplicationController
  def create
    user = User.find_by(id: params[:user])
    new_friend_request = user.friend_requests.build(friend_id: current_user.id)

    if new_friend_request.save
      p 'WASSSSUUUUUPP'
    else
      p 'BRO ADD ME ALREADY'
    end
  end

  def destroy
  end
end
