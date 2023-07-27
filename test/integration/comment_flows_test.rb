require "test_helper"

class CommentFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'create new comment' do
    sign_in users(:castiel)

    post comments_path,
      params: {
        comment: {
          content: "I'm right here.",
          post_id: posts(:sam_post).id
        }
      }

    assert_response :redirect
    follow_redirect!

    assert_select '.comments-toggle', '1 Comment'
    assert_equal "I'm right here.", posts(:sam_post).comments.first.content
  end
end
