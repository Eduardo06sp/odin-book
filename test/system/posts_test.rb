require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test 'creating text-only post' do
    sign_in users(:dean)

    visit posts_path
    assert_selector 'h2', text: 'Your feed'

    fill_in 'post_content', with: 'I am looking for Cas!'

    click_button 'Create Post'

    assert_selector 'p.post-content', text: 'I am looking for Cas!'
  end
end
