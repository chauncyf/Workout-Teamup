require "application_system_test_case"

class ActivityParticipantsTest < ApplicationSystemTestCase
  setup do
    @activity_participant = activity_participants(:one)
  end

  test "visiting the index" do
    visit activity_participants_url
    assert_selector "h1", text: "Activity Participants"
  end

  test "creating a Activity participant" do
    visit activity_participants_url
    click_on "New Activity Participant"

    fill_in "Activity", with: @activity_participant.activity_id
    fill_in "Identity", with: @activity_participant.identity
    fill_in "Participant", with: @activity_participant.user_id
    click_on "Create Activity participant"

    assert_text "Activity participant was successfully created"
    click_on "Back"
  end

  test "updating a Activity participant" do
    visit activity_participants_url
    click_on "Edit", match: :first

    fill_in "Activity", with: @activity_participant.activity_id
    fill_in "Identity", with: @activity_participant.identity
    fill_in "Participant", with: @activity_participant.user_id
    click_on "Update Activity participant"

    assert_text "Activity participant was successfully updated"
    click_on "Back"
  end

  test "destroying a Activity participant" do
    visit activity_participants_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Activity participant was successfully destroyed"
  end
end
