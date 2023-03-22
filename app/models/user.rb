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

  has_many :comments
  has_many :commented_posts,
           through: :comments,
           source: :post

  has_one_attached :avatar

  validate :avatar_format, :avatar_size, if: -> { avatar.attached? }

  private

  def avatar_format
    unless avatar.blob.image?
      errors.add(:base, 'Attached file must be an image')
    end
  end

  def avatar_size
    if avatar.blob.byte_size > 5.megabytes
      errors.add(:base, 'Attached file size must be less than 5 megabytes')
    end
  end
end
