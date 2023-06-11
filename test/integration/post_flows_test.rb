require "test_helper"

class PostFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # test "the truth" do
  #   assert true
  # end

  test 'redirects to sign in page if not signed in' do
    get '/posts'

    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_response :success

    assert_select 'h2', 'Log in'
  end

  test 'create new text post' do
    sign_in users(:dean)

    post posts_path,
      params: {
        post: {
          content: 'I am out of salt!'
        }
      }

    assert_response :redirect
    follow_redirect!

    assert_select 'li', /I am out of salt!/
  end
end
