require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # test "should get create" do
  #   get comments_create_url
  #   assert_response :success
  # end

  test 'should create comment' do
    sign_in users(:dean)

    assert_difference('Comment.all.length') do
      post comments_path, params: {
        comment: {
          content: 'greetings fellas',
          post_id: posts(:dean_post).id},
        commit: 'Create Comment'
      }
    end

    assert_response :redirect
    assert_equal 'Added comment.', flash[:notice]
  end
end
