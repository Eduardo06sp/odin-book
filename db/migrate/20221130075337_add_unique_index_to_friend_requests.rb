class AddUniqueIndexToFriendRequests < ActiveRecord::Migration[7.0]
  def change
    add_index :friend_requests,
              'LEAST(user_id, friend_id), GREATEST(user_id, friend_id)',
              name: 'index_friend_requests_on_user_id_and_friend_id',
              unique: true

    add_index :friend_requests,
              'GREATEST(user_id, friend_id), LEAST(user_id, friend_id)',
              name: 'index_friend_requests_on_friend_id_and_user_id',
              unique: true
  end
end
