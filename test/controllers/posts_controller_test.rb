require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # test "should get index" do
  #   get posts_index_url
  #   assert_response :success
  # end

  test 'should create new post' do
    sign_in users(:dean)

    assert_difference('Post.count') do
      post '/posts',
           params: { post:
                     { content: 'Greetings fellow friend!' } }
    end

    assert_response :redirect
    assert_equal 'Successfully created new post.', flash[:notice]
  end
end
