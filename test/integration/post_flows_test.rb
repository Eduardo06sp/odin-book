require "test_helper"

class PostFlowsTest < ActionDispatch::IntegrationTest
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
end
