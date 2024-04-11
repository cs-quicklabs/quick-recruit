require "test_helper"

class OnboardingTest < ActionDispatch::IntegrationTest

  # Dashboard
  test "admin can sign in" do
    user = users(:admin)

    get new_session_url
    assert_response :success

    post session_url, params: { email: user.email, password: "password" }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "You have been logged in."
  end

  test "recruiter can sign in" do
    user = users(:recruiter)

    get new_session_url
    assert_response :success

    post session_url, params: { email: user.email, password: "password" }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "You have been logged in."
  end

  test "data can sign in" do
    user = users(:data)

    get new_session_url
    assert_response :success

    post session_url, params: { email: user.email, password: "password" }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "You have been logged in."
  end

  test "interviewer can sign in" do
    user = users(:interviewer)

    get new_session_url
    assert_response :success

    post session_url, params: { email: user.email, password: "password" }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "You have been logged in."
  end

  test "wrong credentials can not sign in" do
    get new_session_url
    assert_response :success

    post session_url, params: { email: "random@gmail.com", password: "random" }
    assert_response :unprocessable_entity
    assert_select "p", "Your email or password is incorrect."
  end

  test "inactive can not sign in" do
    get new_session_url
    assert_response :success

    post session_url, params: { email: "inactive@gmail.com", password: "password" }
    assert_response :unprocessable_entity
    assert_select "p", "Your account has been disabled. Please connect with your admin."
  end
end
