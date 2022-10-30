class CreateJoinTableFriendUser < ActiveRecord::Migration[7.0]
  def change
    create_join_table :friends, :users do |t|
      t.index [:friend_id, :user_id]
      t.index [:user_id, :friend_id]
    end
  end
end
