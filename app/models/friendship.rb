class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend,
             class_name: 'User'

  validate :friend_request_present?, on: :accept_friend_request

  def friend_request_present?
    friend_request = FriendRequest.find_by(user_id: user, friend_id: friend)

    return unless friend_request.nil?

    errors.add :base,
               :friend_request_missing,
               message: 'associated friend request missing'
  end
end
