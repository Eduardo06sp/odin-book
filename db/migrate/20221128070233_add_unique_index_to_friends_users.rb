class AddUniqueIndexToFriendsUsers < ActiveRecord::Migration[7.0]
  def change
    remove_index :friends_users, %i[user_id friend_id]
    add_index :friends_users, %i[user_id friend_id], unique: true
  end
end
