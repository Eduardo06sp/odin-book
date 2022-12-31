class FriendshipsController < ApplicationController
  after_action :add_friend_back, only: :create
  after_action :delete_associated_request, only: :create

  def create
    user = User.find_by(id: params[:user])
    friend = User.find_by(id: params[:friend])

    friendship = user.friendships.build(friend_id: friend.id)

    if friendship.save(context: :accept_friend_request)
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

  def add_friend_back
    friend = User.find_by(id: params[:friend])
    inverse_friendship = friend.friendships.build(friend_id: params[:user])

    if inverse_friendship.save
      puts 'SAY HELLO BACK, YA GOT ADDED BACK AUTOMATICALLY'
    else
      flash[:alert] = 'Unable to complete friendship.'
    end
  end

  def delete_associated_request
    friend_request = FriendRequest.find_by(friend_id: params[:friend], user_id: params[:user])

    friend_request.destroy
  end
end
