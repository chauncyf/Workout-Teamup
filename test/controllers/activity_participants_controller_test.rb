require 'test_helper'

class ActivityParticipantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activity_participant = activity_participants(:one)
  end

  test "should get index" do
    get activity_participants_url
    assert_response :success
  end

  test "should get new" do
    get new_activity_participant_url
    assert_response :success
  end

  test "should create activity_participant" do
    assert_difference('ActivityParticipant.count') do
      post activity_participants_url, params: { activity_participant: { activity_id: @activity_participant.activity_id, identity: @activity_participant.identity, participant_id: @activity_participant.participant_id } }
    end

    assert_redirected_to activity_participant_url(ActivityParticipant.last)
  end

  test "should show activity_participant" do
    get activity_participant_url(@activity_participant)
    assert_response :success
  end

  test "should get edit" do
    get edit_activity_participant_url(@activity_participant)
    assert_response :success
  end

  test "should update activity_participant" do
    patch activity_participant_url(@activity_participant), params: { activity_participant: { activity_id: @activity_participant.activity_id, identity: @activity_participant.identity, participant_id: @activity_participant.participant_id } }
    assert_redirected_to activity_participant_url(@activity_participant)
  end

  test "should destroy activity_participant" do
    assert_difference('ActivityParticipant.count', -1) do
      delete activity_participant_url(@activity_participant)
    end

    assert_redirected_to activity_participants_url
  end
end
