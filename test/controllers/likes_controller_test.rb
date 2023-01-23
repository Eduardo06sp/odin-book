require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # test "should get create" do
  #   get likes_create_url
  #   assert_response :success
  # end

  test 'can create a like' do
    sign_in users(:dean)

    assert_difference('Like.count') do
      post likes_path,
           params: {
             user: users(:dean).id,
             post: posts(:dean_post).id
           }
    end

    assert_response :redirect
    assert_equal 'Liked the post!', flash[:notice]
  end

  test 'can delete a like' do
    sign_in users(:dean)

    assert_difference('Like.count', -1) do
      delete like_path(likes(:dean_like))
    end

    assert_response :redirect
    assert_equal 'Unliked post.', flash[:notice]
  end
end
