require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @badger = users(:badger)
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: {
        user: {
          email: 'ferret@mcferret.com',
          name: 'Ferret McFerret',
          password: 'FerretsRule',
          password_confirmation: 'FerretsRule'
        }
      }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should not create user who's passwords do not match" do
    assert_no_difference('User.count') do
      post users_url, params: {
        user: {
          email: 'ferret@mcferret.com',
          name: 'Ferret McFerret',
          password: 'FerretsRule',
          password_confirmation: 'BadgersRule'
        }
      }
    end
  end
end
