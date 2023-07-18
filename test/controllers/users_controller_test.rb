require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

#  test "should get index" do
#    get users_index_url
#    assert_response :success
#  end
#
#  test "should get show" do
#    get users_show_url
#    assert_response :success
#  end

  test 'should show send friend request button by default' do
    sign_in users(:dean)

    get users_path
    assert_response :success

    assert_select 'div.user-listing' do
      assert_select 'button', text: 'Send Friend Request', count: 2
    end
  end
end
