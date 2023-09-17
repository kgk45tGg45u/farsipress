require "application_system_test_case"

class FeedsTest < ApplicationSystemTestCase
  setup do
    @feed = feeds(:one)
  end

  test "visiting the index" do
    visit feeds_url
    assert_selector "h1", text: "Feeds"
  end

  test "should create feed" do
    visit feeds_url
    click_on "New feed"

    fill_in "Name", with: @feed.name
    fill_in "Url", with: @feed.url
    click_on "Create Feed"

    assert_text "Feed was successfully created"
    click_on "Back"
  end

  test "should update Feed" do
    visit feed_url(@feed)
    click_on "Edit this feed", match: :first

    fill_in "Name", with: @feed.name
    fill_in "Url", with: @feed.url
    click_on "Update Feed"

    assert_text "Feed was successfully updated"
    click_on "Back"
  end

  test "should destroy Feed" do
    visit feed_url(@feed)
    click_on "Destroy this feed", match: :first

    assert_text "Feed was successfully destroyed"
  end
end
