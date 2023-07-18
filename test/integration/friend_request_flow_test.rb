require "test_helper"

class FriendRequestFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # test "the truth" do
  #   assert true
  # end

  test 'can send a friend request' do
    friend_requests_count = 'users(:sam).friend_requests.count'
    friend_notifications_count = 'users(:sam).notifications.count'

    sign_in users(:dean)

    assert_difference([friend_requests_count, friend_notifications_count]) do
      post friend_requests_path,
           params: {
             user: users(:sam).id,
             friend: users(:dean).id
           }
    end

    assert_response :redirect

    get users_path
    assert_response :success
    assert_select 'div.user-listing' do
      assert_select 'button', text: 'Cancel Friend Request', count: 1
    end
  end

  test 'cannot send duplicate friend requests' do
    sign_in users(:dean)

    post friend_requests_path,
         params: {
           user: users(:sam).id,
           friend: users(:dean).id
         }
    assert_response :redirect

    assert_no_difference('FriendRequest.count') do
      post friend_requests_path,
           params: {
             user: users(:sam).id,
             friend: users(:dean).id
           }
    end
    assert_response :redirect

    assert_equal 'Unable to send friend request.', flash[:alert]
  end

  test 'cannot send friend request if user already received one' do
    dean = login(:dean)
    sam = login(:sam)

    dean.post friend_requests_path,
              params: {
                user: users(:sam).id,
                friend: users(:dean).id
              }
    dean.assert_response :redirect
    assert_equal 'Sent friend request!', dean.flash[:notice]

    sam.post friend_requests_path,
             params: {
               user: users(:dean).id,
               friend: users(:sam).id
             }
    sam.assert_response :redirect
    assert_equal 'Unable to send friend request.', sam.flash[:alert]
  end

  def login(user)
    open_session do |session|
      u = users(user)
      session.https!
      session.post '/users/sign_in',
                   params: {
                     user: {
                       email: u.email,
                       password: "#{user}123456"
                     }
                   }
      session.https!(false)

      session.get root_path
      session.assert_response :success
    end
  end
end
