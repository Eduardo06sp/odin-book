class FriendshipsController < ApplicationController
  around_action :complete_friendship, only: :create

  def create
    user = User.find_by(id: params[:user])
    friendship = user.friendships.build(friend_id: params[:friend])

    friendship.save!(context: :accept_friend_request)

    redirect_back_or_to root_path
  end

  def destroy
    friendship = Friendship.find_sole_by(id: params[:id])

    puts 'THIS SHALL DESTROY THE FRIENDSHIP'

    if friendship.destroy
      puts 'FRIENDSHIP DESTROYED'
    else
      puts 'UNABLE TO DESTROY FRIENDSHIP, GO SAY SORRY'
    end

    redirect_back_or_to root_path
  end

  def add_friend_back
    friend = User.find_by(id: params[:friend])
    inverse_friendship = friend.friendships.build(friend_id: params[:user])

    inverse_friendship.save!
  end

  def delete_associated_request
    friend_request = FriendRequest.find_by(friend_id: params[:friend], user_id: params[:user])

    friend_request.destroy!
  end

  def complete_friendship
    ActiveRecord::Base.transaction do
      yield
      add_friend_back
      delete_associated_request
    end
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = 'Unable to add friend.'
    redirect_back_or_to root_path
  end
end
