class FriendshipsController < ApplicationController
  def create
    user = User.find_by(id: params[:user])
    friend = User.find_by(id: params[:friend])
    friend_request = FriendRequest.find_by(friend_id: friend, user_id: user)

    friendship = user.friendships.build(friend_id: friend.id)
    inverse_friendship = friend.friendships.build(friend_id: user.id)

    if friendship.save(context: :accept_friend_request) && inverse_friendship.save
      friend_request.destroy

      puts 'SAY HELLO, YOU ARE NOW FRENDS'
    else
      flash[:alert] = 'Unable to add friend.'
    end

    redirect_back_or_to root_path
  end

  def destroy
    user = User.find_by(id: params[:user])
    friend = User.find_by(id: params[:friend])

    puts 'THIS SHALL DESTROY THE FRIENDSHIP'

    if user.friends.destroy(friend) && friend.friends.destroy(user)
      puts 'FRIENDSHIP DESTROYED'
    else
      puts 'UNABLE TO DESTROY FRIENDSHIP, GO SAY SORRY'
    end

    redirect_back_or_to root_path
  end
end
