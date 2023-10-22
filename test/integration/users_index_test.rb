require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    i = 0
    User.paginate(page: 1, per_page: 10).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.username
      i += 1
    end
    # Make sure we did all those selects
    assert_equal 10, i
  end

end
