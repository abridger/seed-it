require 'test_helper'

class MeadowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meadow = meadows(:valid)
    @badger = users(:badger)
  end

  test "should get index" do
    get meadows_url
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get new_meadow_url
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should get new when logged in" do
    log_in_as(@badger)
    get new_meadow_url
    assert_response :success
  end

  test "should redirect create when not logged in" do
    assert_no_difference('Meadow.count') do
      post meadows_url, params: {
        meadow: {
          description: @meadow.description,
          name: @meadow.name
        }
      }
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should create valid meadow when logged in" do
    log_in_as(@badger)
    assert_difference('Meadow.count') do
      post meadows_url, params: {
        meadow: {
          description: @meadow.description,
          name: @meadow.name
        }
      }
    end

    assert_redirected_to meadow_url(Meadow.last)
  end

  test "should not create a meadow with an invalid name" do
    log_in_as(@badger)
    assert_no_difference('Meadow.count') do
      post meadows_url, params: {
        meadow: {
          description: @meadow.description,
          name: ''
        }
      }
    end
  end

  test "should not create a meadow with an invalid description" do
    log_in_as(@badger)
    assert_no_difference('Meadow.count') do
      post meadows_url, params: {
        meadow: {
          description: '',
          name: @meadow.name
        }
      }
    end
  end

  test "should show meadow" do
    get meadow_url(@meadow)
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_meadow_url(@meadow)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should get edit when logged in" do
    log_in_as(@badger)
    get edit_meadow_url(@meadow)
    assert_response :success
  end

  test "should redirect update when not logged in" do
    patch meadow_url(@meadow), params: {
      meadow: {
        description: @meadow.description,
        name: @meadow.name
      }
    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should update meadow" do
    log_in_as(@badger)
    patch meadow_url(@meadow), params: {
      meadow: {
        description: @meadow.description,
        name: @meadow.name
      }
    }
    assert_redirected_to meadow_url(@meadow)
  end

  test "should destroy meadow" do
    log_in_as(@badger)
    assert_difference('Meadow.count', -1) do
      delete meadow_url(@meadow)
    end

    assert_redirected_to meadows_url
  end
end
