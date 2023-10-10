require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "Example User", email: "user@example.com",
      password: "foobar", password_confirmation: "foobar")
  end

  test "basic is valid" do
    assert @user.valid?
  end

  test "needs password" do
    @user.password_confirmation += ' '
    assert_not @user.valid?
  end

  test "missing name" do
    u = User.new(username: "", email: "user@example.com",
      password: "foobar", password_confirmation: "foobar")
    assert_not u.valid?
  end

  test "bad email" do
    u = User.new(username: "fsda", email: "horkye",
      password: "foobar", password_confirmation: "foobar")
    assert_not u.valid?
  end
end
