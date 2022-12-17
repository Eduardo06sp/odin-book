require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # test "the truth" do
  #   assert true
  # end

  test 'can add friend' do
    friend_counts = %w[users(:dean).friends.count users(:sam).friends.count]
    sign_in users(:dean)

    post friend_requests_path,
         params: { user: users(:sam).id }
    assert_response :redirect

    assert_difference(friend_counts) do
      post friendships_path,
           params: {
             user: users(:sam).id,
             friend: users(:dean).id
           }
    end
    assert_response :redirect
  end
end
