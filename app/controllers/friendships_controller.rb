class FriendshipsController < ApplicationController
  around_action :complete_friendship, only: :create
  around_action :destroy_friendship, only: :destroy

  def create
    user = User.find_by(id: params[:user])
    friendship = user.friendships.build(friend_id: params[:friend])

    friendship.save!(context: :accept_friend_request)

    redirect_back_or_to root_path
  end

  def destroy
    friendship = Friendship.find_sole_by(id: params[:id])

    friendship.destroy!

    redirect_back_or_to root_path
  end

  def destroy_inverse_friendship
    inverse_friendship = Friendship.find_sole_by(user_id: params[:friend], friend_id: params[:user])

    inverse_friendship.destroy!
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

  def notify_friend
    user = User.find_by(id: params[:user])
    friend = User.find_by(id: params[:friend])

    friend.notifications.create!(description:
                                 '<span class="notification_username">'\
                                 "#{user.email}"\
                                 '</span>'\
                                 ' accepted your friend request! You are now friends!')
  end

  def complete_friendship
    ActiveRecord::Base.transaction do
      yield
      add_friend_back
      delete_associated_request
      notify_friend
    end
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = 'Unable to add friend.'
    redirect_back_or_to root_path
  end

  def destroy_friendship
    ActiveRecord::Base.transaction do
      yield
      destroy_inverse_friendship
    end
  end
end
