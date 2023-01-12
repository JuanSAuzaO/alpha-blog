require "test_helper"

class UsersSignUpTest < ActionDispatch::IntegrationTest

  test "get new user form and create user" do
    get signup_path
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "Sebas", email: "sebas@gmail.com", password: "123456" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sebas", response.body
  end

  test "get new user form and reject invalid user" do
    get signup_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "Sebas", email: "sebasgmail.com", password: "123456" } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
  
end