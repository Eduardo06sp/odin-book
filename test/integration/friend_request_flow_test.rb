require "test_helper"

class FriendRequestFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # test "the truth" do
  #   assert true
  # end

  test 'can send a friend request' do
    sign_in users(:dean)

    assert_difference('FriendRequest.count') do
      post friend_requests_path,
           params: { user: users(:sam).id }
    end

    assert_response :redirect

    get users_path
    assert_response :success
    assert_select 'ul' do
      assert_select 'button', text: 'Cancel Friend Request', count: 1
    end
  end

  test 'cannot send duplicate friend requests' do
    sign_in users(:dean)

    post friend_requests_path,
         params: { user: users(:sam).id }
    assert_response :redirect

    assert_no_difference('FriendRequest.count') do
      post friend_requests_path,
           params: { user: users(:sam).id }
    end
    assert_response :redirect

    assert_equal 'Unable to send friend request.', flash[:alert]
  end
end
