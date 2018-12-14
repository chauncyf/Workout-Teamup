require 'test_helper'

class ActivityContentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activity_content = activity_contents(:one)
  end

  test "should get index" do
    get activity_contents_url
    assert_response :success
  end

  test "should get new" do
    get new_activity_content_url
    assert_response :success
  end

  test "should create activity_content" do
    assert_difference('ActivityContent.count') do
      post activity_contents_url, params: { activity_content: { activity_id: @activity_content.activity_id, alert: @activity_content.alert, customize_sport: @activity_content.customize_sport, dur_unit: @activity_content.dur_unit, duration: @activity_content.duration, equipment: @activity_content.equipment, quan_unit: @activity_content.quan_unit, quantity: @activity_content.quantity, sport_option: @activity_content.sport_option, strength: @activity_content.strength, suggestion: @activity_content.suggestion } }
    end

    assert_redirected_to activity_content_url(ActivityContent.last)
  end

  test "should show activity_content" do
    get activity_content_url(@activity_content)
    assert_response :success
  end

  test "should get edit" do
    get edit_activity_content_url(@activity_content)
    assert_response :success
  end

  test "should update activity_content" do
    patch activity_content_url(@activity_content), params: { activity_content: { activity_id: @activity_content.activity_id, alert: @activity_content.alert, customize_sport: @activity_content.customize_sport, dur_unit: @activity_content.dur_unit, duration: @activity_content.duration, equipment: @activity_content.equipment, quan_unit: @activity_content.quan_unit, quantity: @activity_content.quantity, sport_option: @activity_content.sport_option, strength: @activity_content.strength, suggestion: @activity_content.suggestion } }
    assert_redirected_to activity_content_url(@activity_content)
  end

  test "should destroy activity_content" do
    assert_difference('ActivityContent.count', -1) do
      delete activity_content_url(@activity_content)
    end

    assert_redirected_to activity_contents_url
  end
end
