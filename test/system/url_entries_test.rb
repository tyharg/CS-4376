require "application_system_test_case"

class UrlEntriesTest < ApplicationSystemTestCase
  setup do
    @url_entry = url_entries(:one)
  end

  test "visiting the index" do
    visit url_entries_url
    assert_selector "h1", text: "Url entries"
  end

  test "should create url entry" do
    visit url_entries_url
    click_on "New url entry"

    fill_in "Description", with: @url_entry.description
    fill_in "Expire", with: @url_entry.expire
    fill_in "Url", with: @url_entry.url
    click_on "Create Url entry"

    assert_text "Url entry was successfully created"
    click_on "Back"
  end

  test "should update Url entry" do
    visit url_entry_url(@url_entry)
    click_on "Edit this url entry", match: :first

    fill_in "Description", with: @url_entry.description
    fill_in "Expire", with: @url_entry.expire
    fill_in "Url", with: @url_entry.url
    click_on "Update Url entry"

    assert_text "Url entry was successfully updated"
    click_on "Back"
  end

  test "should destroy Url entry" do
    visit url_entry_url(@url_entry)
    click_on "Destroy this url entry", match: :first

    assert_text "Url entry was successfully destroyed"
  end
end
