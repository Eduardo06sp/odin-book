class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friend_requests
  has_many :friendships
  has_many :friends,
           through: :friendships

  has_many :likes
  has_many :liked_posts,
           through: :likes,
           source: :post

  has_many :notifications

  has_many :posts
end
