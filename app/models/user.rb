class User < ApplicationRecord
  require 'open-uri'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

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

  def profile_details
    {
      biography:,
      real_name:,
      country:,
      state:,
      city:
    }
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.username = auth.info.nickname
      user.password = Devise.friendly_token[0, 20]
      user.avatar.attach(io: URI.parse(auth.info.image).open, filename: 'github-avatar')
    end
  end

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
