require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: { session: { email: "barfy", password: "barfy" }}
    assert_template "sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  test "login with an actual user" do
    get login_path
    post login_path, params: { session: { email: "MyString2@winx.com", password: "secret22" }}
    assert_template "sessions/new"
    follow_redirect!
    assert_template "users/show"
    assert flash.empty?
    # puts "QQQ: #{ response.body }"
  end
end
