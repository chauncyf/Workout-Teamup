require "application_system_test_case"

class ActivityTagsTest < ApplicationSystemTestCase
  setup do
    @activity_tag = activity_tags(:one)
  end

  test "visiting the index" do
    visit activity_tags_url
    assert_selector "h1", text: "Activity Tags"
  end

  test "creating a Activity tag" do
    visit activity_tags_url
    click_on "New Activity Tag"

    fill_in "Activity", with: @activity_tag.activity_id
    fill_in "Tag", with: @activity_tag.tag_id
    click_on "Create Activity tag"

    assert_text "Activity tag was successfully created"
    click_on "Back"
  end

  test "updating a Activity tag" do
    visit activity_tags_url
    click_on "Edit", match: :first

    fill_in "Activity", with: @activity_tag.activity_id
    fill_in "Tag", with: @activity_tag.tag_id
    click_on "Update Activity tag"

    assert_text "Activity tag was successfully updated"
    click_on "Back"
  end

  test "destroying a Activity tag" do
    visit activity_tags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Activity tag was successfully destroyed"
  end
end
