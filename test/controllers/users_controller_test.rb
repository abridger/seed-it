require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @badger = users(:badger)
    @ferret = users(:ferret)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: {
        user: {
          email: 'Weasel@mcWeasel.com',
          name: 'Weasel McWeasel',
          password: 'WeaselsRule',
          password_confirmation: 'WeaselsRule'
        }
      }
    end

    assert_redirected_to root_url
  end

  test "should not create user who's passwords do not match" do
    assert_no_difference('User.count') do
      post users_url, params: {
        user: {
          email: 'Weasel@mcWeasel.com',
          name: 'Weasel McWeasel',
          password: 'WeaselsRule',
          password_confirmation: 'BadgersRule'
        }
      }
    end
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@badger)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@badger), params: {
      user: {
        name: @badger.name,
        email: @badger.email
      }
    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@ferret)
    get edit_user_path(@badger)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@ferret)
    patch user_path(@badger), params: {
      user: {
        name: @badger.name,
        email: @badger.email
      }
    }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@ferret)
    assert_not @ferret.admin?
    patch user_path(@ferret), params: {
      user: {
        admin: true
      }
    }
    assert_not @ferret.reload.admin?
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@badger)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@ferret)
    assert_no_difference 'User.count' do
      delete user_path(@badger)
    end
    assert_redirected_to root_url
  end
end
