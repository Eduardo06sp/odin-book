require "test_helper"

class NotificationFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # test "the truth" do
  #   assert true
  # end

  test 'should create notification after friend request' do
    friend_notifications = users(:sam).notifications

    sign_in users(:dean)

    post friend_requests_path,
         params: {
           user: users(:sam).id,
           friend: users(:dean).id
         }

    assert_response :redirect
    assert_equal '<span class="notification_username">dean@hunter.com</span> '\
                 'sent you a friend request.',
                 friend_notifications.first.description
  end

  test 'should create notification after friendship is created' do
    user_notifications = users(:dean).notifications

    sign_in users(:dean)

    post friend_requests_path,
         params: {
           user: users(:sam).id,
           friend: users(:dean).id
         }
    assert_response :redirect

    post friendships_path,
         params: {
           user: users(:sam).id,
           friend: users(:dean).id
         }
    assert_response :redirect

    assert_equal '<span class="notification_username">sam@hunter.com</span> '\
                 'accepted your friend request! You are now friends!',
                 user_notifications.first.description
  end

  test 'should delete notification' do
    user_notifications = users(:castiel).notifications
    notification = user_notifications.first

    sign_in users(:castiel)

    assert_difference('user_notifications.count', -1) do
      delete notification_path(notification)
    end
  end
end
