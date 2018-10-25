require 'test_helper'

class UserLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_location = user_locations(:one)
  end

  test "should get index" do
    get user_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_user_location_url
    assert_response :success
  end

  test "should create user_location" do
    assert_difference('UserLocation.count') do
      post user_locations_url, params: { user_location: { latitude: @user_location.latitude, longitude: @user_location.longitude, status: @user_location.status, user_id: @user_location.user_id } }
    end

    assert_redirected_to user_location_url(UserLocation.last)
  end

  test "should show user_location" do
    get user_location_url(@user_location)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_location_url(@user_location)
    assert_response :success
  end

  test "should update user_location" do
    patch user_location_url(@user_location), params: { user_location: { latitude: @user_location.latitude, longitude: @user_location.longitude, status: @user_location.status, user_id: @user_location.user_id } }
    assert_redirected_to user_location_url(@user_location)
  end

  test "should destroy user_location" do
    assert_difference('UserLocation.count', -1) do
      delete user_location_url(@user_location)
    end

    assert_redirected_to user_locations_url
  end
end
