require "application_system_test_case"

class ActivityContentsTest < ApplicationSystemTestCase
  setup do
    @activity_content = activity_contents(:one)
  end

  test "visiting the index" do
    visit activity_contents_url
    assert_selector "h1", text: "Activity Contents"
  end

  test "creating a Activity content" do
    visit activity_contents_url
    click_on "New Activity Content"

    fill_in "Activity", with: @activity_content.activity_id
    fill_in "Alert", with: @activity_content.alert
    fill_in "Customize Sport", with: @activity_content.customize_sport
    fill_in "Dur Unit", with: @activity_content.dur_unit
    fill_in "Duration", with: @activity_content.duration
    fill_in "Equipment", with: @activity_content.equipment
    fill_in "Quan Unit", with: @activity_content.quan_unit
    fill_in "Quantity", with: @activity_content.quantity
    fill_in "Sport Option", with: @activity_content.sport_option
    fill_in "Strength", with: @activity_content.strength
    fill_in "Suggestion", with: @activity_content.suggestion
    click_on "Create Activity content"

    assert_text "Activity content was successfully created"
    click_on "Back"
  end

  test "updating a Activity content" do
    visit activity_contents_url
    click_on "Edit", match: :first

    fill_in "Activity", with: @activity_content.activity_id
    fill_in "Alert", with: @activity_content.alert
    fill_in "Customize Sport", with: @activity_content.customize_sport
    fill_in "Dur Unit", with: @activity_content.dur_unit
    fill_in "Duration", with: @activity_content.duration
    fill_in "Equipment", with: @activity_content.equipment
    fill_in "Quan Unit", with: @activity_content.quan_unit
    fill_in "Quantity", with: @activity_content.quantity
    fill_in "Sport Option", with: @activity_content.sport_option
    fill_in "Strength", with: @activity_content.strength
    fill_in "Suggestion", with: @activity_content.suggestion
    click_on "Update Activity content"

    assert_text "Activity content was successfully updated"
    click_on "Back"
  end

  test "destroying a Activity content" do
    visit activity_contents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Activity content was successfully destroyed"
  end
end
