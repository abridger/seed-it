require 'test_helper'

class MeadowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meadow = meadows(:valid)
    @user = users(:badger)
  end

  test "should get index" do
    get meadows_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@user)
    get new_meadow_url
    assert_response :success
  end

  test "should create valid meadow" do
    log_in_as(@user)
    assert_difference('Meadow.count') do
      post meadows_url, params: { meadow: { description: @meadow.description, name: @meadow.name } }
    end

    assert_redirected_to meadow_url(Meadow.last)
  end

  test "should not create a meadow with an invalid name" do
    log_in_as(@user)
    assert_no_difference('Meadow.count') do
      post meadows_url, params: { meadow: { description: @meadow.description, name: '' } }
    end
  end

  test "should not create a meadow with an invalid description" do
    log_in_as(@user)
    assert_no_difference('Meadow.count') do
      post meadows_url, params: { meadow: { description: '', name: @meadow.name } }
    end
  end

  test "should show meadow" do
    get meadow_url(@meadow)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_meadow_url(@meadow)
    assert_response :success
  end

  test "should update meadow" do
    log_in_as(@user)
    patch meadow_url(@meadow), params: { meadow: { description: @meadow.description, name: @meadow.name } }
    assert_redirected_to meadow_url(@meadow)
  end

  test "should destroy meadow" do
    log_in_as(@user)
    assert_difference('Meadow.count', -1) do
      delete meadow_url(@meadow)
    end

    assert_redirected_to meadows_url
  end
end
