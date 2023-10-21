require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
      user: {
        username: "",
        email: "joe", # email is ignored
        password: "splibitch",
        password_confirmation: "splibitch_x",
      }
    }
    assert_template 'users/edit'
    assert_select 'div#error_explanation .alert', 'The form contains 2 errors.'
    assert_select 'div#error_explanation ul li[1]', "Username can't be blank"
    assert_select 'div#error_explanation ul li[2]', "Password confirmation doesn't match Password"
  end

  test "unsuccessful edit: can't steal another user's username" do
    get edit_user_path(@user)
    user2 = users(:user2)
    patch user_path(user2), params: {
      user: {
        username: @user.username,
        email: user2.email,
      }
    }
    assert_template 'users/edit'
    assert_select 'div#error_explanation .alert', 'The form contains 1 error.'
    assert_select 'div#error_explanation ul li[1]', "Username has already been taken"

      # assert_select 'div.row aside section.user_info h1', @user.username
  end

  test "successful edit" do
    get edit_user_path(@user)
    name = "new-joe"
    patch user_path(@user), params: {
      user: {
        username: name,
        email: @user.email,
      }
    }
    assert_redirected_to @user
    follow_redirect!
    assert_not flash.empty?
    @user.reload
    assert_equal name, @user.username
  end
end
