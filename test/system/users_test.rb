require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit users_url
  #
  #   assert_selector "h1", text: "Users"
  # end

  test 'signing up' do
    visit new_user_registration_path
    assert_selector 'h2', text: 'Sign up'

    fill_in 'Email', with: 'sam@hunter.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_on 'Sign up'

    assert_text 'Posts#index'
  end
end