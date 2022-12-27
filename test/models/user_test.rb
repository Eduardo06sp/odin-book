require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'should raise error when saving duplicate friendship' do
    dean = users(:dean)
    sam = users(:sam)

    Friendship.create(user_id: sam.id, friend_id: dean.id)

    assert_raises(ActiveRecord::RecordNotUnique) do
      Friendship.create(user_id: sam.id, friend_id: dean.id)
    end
  end
end
