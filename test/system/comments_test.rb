require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test 'adding comment to another post' do
    sign_in users(:castiel)

    visit posts_path
    assert_selector 'h2', text: 'Your feed'
    assert_selector 'p.post-content', text: "I'm looking for Cas!"

    assert_button '0 Comments', count: 1
    refute_button '1 Comment'

    click_button '0 Comments'
    assert_selector '.post-comments', count: 1

    fill_in "#{ posts(:sam_post).id }_comment_content", with: "I'm the angel you were looking for."
    click_button 'Create Comment'

    assert_button '1 Comment', count: 1
    click_button '1 Comment'
    assert_selector '.comments-section', text: "I'm the angel you were looking for."
  end
end
