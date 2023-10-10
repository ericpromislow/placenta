require "test_helper"
require 'faker'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "Example User", email: "user@example.com",
      password: "foobar", password_confirmation: "foobar")
  end

  test "basic is valid" do
    assert @user.valid?
  end

  test "space not good" do
    @user.username = '     ';
    assert_not @user.valid?
    assert_includes @user.errors.full_messages, "Username can't be blank"
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

  test "email too long" do
    @user.email = 'x' * 150 + '@cheeps.com'
    assert_not  @user.valid?
    assert_includes @user.errors.full_messages, "Email is too long (maximum is 150 characters)"
  end

  test "email in use" do
    user1 = User.all[0]
    username = Faker::Name.name
    password = Faker::Internet.password
    user = User.new(username: username, email: user1.email, password: password, password_confirmation: password)
    user.save
    assert_not  user.valid?
    assert_includes user.errors.full_messages, "Email has already been taken"
  end


  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

end
