class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liking_users,
           through: :likes,
           source: :user

  has_many :comments, dependent: :destroy
  has_many :commenting_users,
           through: :comments,
           source: :user

  has_one_attached :image

  validate :image_format, :image_size, if: -> { image.attached? }

  scope :user_and_friends, ->(user) { where(user_id: [[user.id] + user.friend_ids]) }

  private

  def image_format
    unless image.blob.image?
      errors.add(:base, 'Attached file must be an image')
    end
  end

  def image_size
    if image.blob.byte_size > 5.megabytes
      errors.add(:base, 'Attached file size must be less than 5 megabytes')
    end
  end
end
