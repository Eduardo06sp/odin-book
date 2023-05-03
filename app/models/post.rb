class Post < ApplicationRecord
  belongs_to :user

  has_many :likes
  has_many :liking_users,
           through: :likes,
           source: :user

  has_many :comments
  has_many :commenting_users,
           through: :comments,
           source: :user

  has_one_attached :image

  scope :user_and_friends, ->(user) { where(user_id: [[user.id] + user.friend_ids]) }
end
