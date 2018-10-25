require 'test_helper'

class ActivityTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activity_tag = activity_tags(:one)
  end

  test "should get index" do
    get activity_tags_url
    assert_response :success
  end

  test "should get new" do
    get new_activity_tag_url
    assert_response :success
  end

  test "should create activity_tag" do
    assert_difference('ActivityTag.count') do
      post activity_tags_url, params: { activity_tag: { activity_id: @activity_tag.activity_id, tag_id: @activity_tag.tag_id } }
    end

    assert_redirected_to activity_tag_url(ActivityTag.last)
  end

  test "should show activity_tag" do
    get activity_tag_url(@activity_tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_activity_tag_url(@activity_tag)
    assert_response :success
  end

  test "should update activity_tag" do
    patch activity_tag_url(@activity_tag), params: { activity_tag: { activity_id: @activity_tag.activity_id, tag_id: @activity_tag.tag_id } }
    assert_redirected_to activity_tag_url(@activity_tag)
  end

  test "should destroy activity_tag" do
    assert_difference('ActivityTag.count', -1) do
      delete activity_tag_url(@activity_tag)
    end

    assert_redirected_to activity_tags_url
  end
end
