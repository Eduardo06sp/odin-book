class FriendsController < ApplicationController
  def create
    user = User.find_by(id: params[:user])
    friend = User.find_by(id: params[:friend])
    puts 'THIS SUPPOSED TO BE ADDING A FREND'

    if user.friends << friend && friend.friends << user
      friend_request = FriendRequest.find_sole_by(friend_id: friend, user_id: user)
      friend_request.destroy

      puts 'SAY HELLO, YOU ARE NOW FRENDS'
    else
      puts 'ERROR, CANNOT BE FRENDS SORRY'
    end
  end
end
