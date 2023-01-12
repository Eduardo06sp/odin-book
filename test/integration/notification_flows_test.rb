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
end
