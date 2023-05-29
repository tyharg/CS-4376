require "test_helper"

class UrlEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @url_entry = url_entries(:one)
  end

  test "should get index" do
    get url_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_url_entry_url
    assert_response :success
  end

  test "should create url_entry" do
    assert_difference("UrlEntry.count") do
      post url_entries_url, params: { url_entry: { description: @url_entry.description, expire: @url_entry.expire, url: @url_entry.url } }
    end

    assert_redirected_to url_entry_url(UrlEntry.last)
  end

  test "should show url_entry" do
    get url_entry_url(@url_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_url_entry_url(@url_entry)
    assert_response :success
  end

  test "should update url_entry" do
    patch url_entry_url(@url_entry), params: { url_entry: { description: @url_entry.description, expire: @url_entry.expire, url: @url_entry.url } }
    assert_redirected_to url_entry_url(@url_entry)
  end

  test "should destroy url_entry" do
    assert_difference("UrlEntry.count", -1) do
      delete url_entry_url(@url_entry)
    end

    assert_redirected_to url_entries_url
  end
end
