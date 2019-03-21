require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @badger = users(:badger)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Invalid email
    post password_resets_path, params: {
      password_reset: {
        email: ""
      }
    }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Valid email
    post password_resets_path,
         params: {
           password_reset: {
             email: @badger.email
           }
         }
    assert_not_equal @badger.reset_digest, @badger.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Password reset form
    user = assigns(:user)
    # Wrong email
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url
    # Inactive user
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: user.email)
    assert_redirected_to root_url
    # Right email, right token
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    # Invalid password & confirmation
    patch password_reset_path(user.reset_token),
          params: {
            email: user.email,
            user: {
              password: "ferret",
              password_confirmation: "weasek"
            }
          }
    assert_select 'div#error_explanation'
    # Empty password
    patch password_reset_path(user.reset_token),
          params: {
            email: user.email,
            user: {
              password: "",
              password_confirmation: ""
            }
          }
    assert_select 'div#error_explanation'
    # Valid password & confirmation
    patch password_reset_path(user.reset_token),
          params: {
            email: user.email,
            user: {
              password: "ferret",
              password_confirmation: "ferret"
            }
          }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end

  test "expired token" do
    get new_password_reset_path
    post password_resets_path,
         params: { password_reset: { email: @badger.email } }

    @badger = assigns(:user)
    @badger.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(@badger.reset_token),
          params: { email: @badger.email,
                    user: { password:              "badger",
                            password_confirmation: "badger" } }
    assert_response :redirect
    follow_redirect!
    assert_match /Password reset has expired/i, response.body
  end
end
