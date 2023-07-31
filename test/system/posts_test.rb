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

  test 'creating image-only post' do
    sign_in users(:dean)

    visit posts_path
    assert_selector 'h2', text: 'Your feed'

    click_button 'Attach Image'
    assert_selector 'dialog'

    attach_file 'post_image', 'test/fixtures/files/picture.jpg'

    click_button 'Save'
    click_button 'Create Post'

    assert_selector 'img' do |img|
      assert_match(/picture\.jpg/, img[:src])
    end
  end

  test 'creating post with image and text' do
    sign_in users(:dean)

    visit posts_path
    assert_selector 'h2', text: 'Your feed'

    fill_in 'post_content', with: 'Look at what I discovered up north.'

    click_button 'Attach Image'
    assert_selector 'dialog'

    attach_file 'post_image', 'test/fixtures/files/picture.jpg'

    click_button 'Save'
    click_button 'Create Post'

    assert_selector 'p.post-content', text: 'Look at what I discovered up north.'

    assert_selector 'img' do |img|
      assert_match(/picture\.jpg/, img[:src])
    end
  end
end
