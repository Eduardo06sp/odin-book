class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :friends,
                          class_name: 'User',
                          foreign_key: 'user_id',
                          association_foreign_key: 'friend_id',
                          join_table: 'friends_users'
  has_many :friend_requests
end
