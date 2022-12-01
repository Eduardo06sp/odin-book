class FriendRequest < ApplicationRecord
  belongs_to :friend, class_name: 'User'
  belongs_to :user

  validates_uniqueness_of :user, scope: :friend
  validate :cannot_have_received_request

  def cannot_have_received_request
    incoming_request = FriendRequest.where(user_id: friend_id, friend_id: user_id)

    errors.add(:user, "can't have a pending friend request") if incoming_request.any?
  end
end
