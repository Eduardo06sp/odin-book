require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # test "the truth" do
  #   assert true
  # end

  test 'can add friend' do
    friend_counts = 'users(:dean).friends.count users(:sam).friends.count'
    user_notifications_count = 'users(:dean).notifications.count'

    sign_in users(:dean)

    post friend_requests_path,
         params: {
           user: users(:sam).id,
           friend: users(:dean).id
         }
    assert_response :redirect

    assert_difference([friend_counts, user_notifications_count]) do
      post friendships_path,
           params: {
             user: users(:sam).id,
             friend: users(:dean).id
           }
    end
    assert_response :redirect

    assert_empty users(:dean).friend_requests
    assert_empty users(:sam).friend_requests
  end

  test 'user is friend of new friend after accepting friend request' do
    friend_counts = %w[users(:dean).friends.count users(:sam).friends.count]
    sign_in users(:dean)

    post friend_requests_path,
         params: {
           user: users(:sam).id,
           friend: users(:dean).id
         }
    assert_response :redirect

    assert_difference(friend_counts) do
      post friendships_path,
           params: {
             user: users(:sam).id,
             friend: users(:dean).id
           }
    end
    assert_response :redirect

    assert_equal users(:sam), users(:dean).friends.first
    assert_equal users(:dean), users(:sam).friends.first
  end

  test 'cannot add friend without friend request' do
    sign_in users(:dean)

    assert_no_difference('users(:dean).friends.count') do
      post friendships_path,
           params: {
             user: users(:dean).id,
             friend: users(:sam).id
           }
    end
    assert_response :redirect
    assert_equal 'Unable to add friend.', flash[:alert]
  end

  test 'can unfriend user' do
    sign_in users(:sam)
    friend_counts = %w[users(:sam).friends.count users(:castiel).friends.count]

    assert_difference(friend_counts, -1) do
      delete friendship_path(friendships(:sam_castiel)),
             params: {
               user: users(:sam).id,
               friend: users(:castiel).id
             }
    end
  end
end
