class FriendshipsController < ApplicationController
  def create
    user = User.find_by(id: params[:user])
    friend = User.find_by(id: params[:friend])
    friend_request = FriendRequest.find_by(friend_id: friend, user_id: user)

    if friend_request.nil?
      puts 'FRIEND REQUEST DOES NOT EXIST, YOU CANNOT BE FRIENDS SORRY'
      redirect_back_or_to root_path
      return
    end

    puts 'THIS SUPPOSED TO BE ADDING A FREND'

    if user.friends << friend && friend.friends << user
      friend_request.destroy

      puts 'SAY HELLO, YOU ARE NOW FRENDS'
    else
      puts 'ERROR, CANNOT BE FRENDS SORRY'
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
