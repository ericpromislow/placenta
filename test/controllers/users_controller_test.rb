require "test_helper"
require 'faker'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user1)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should not create duplicate user" do
    assert_difference('User.count', 0) do
      post users_url, params: { user: { email: @user.email, is_temporary: @user.is_temporary, password: 'secret', password_confirmation: 'secret', profile_id: @user.profile_id, username: @user.username } }
    end
    assert_template 'new'
  end

  test "should create user" do
    username = Faker::Name.name
    email = Faker::Internet.email
    password = Faker::Internet.password
    assert_difference('User.count', 1) do
      post users_url, params: { user: { email: email, password: password, password_confirmation: password, profile_id: @user.profile_id, username: username } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { email: @user.email, is_temporary: @user.is_temporary, password: 'secret', password_confirmation: 'secret', profile_id: @user.profile_id, username: @user.username } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  # Stuff that isn't just generated
  test "should set up a new user" do
    get signup_path
    assert_response :success
  end
end
