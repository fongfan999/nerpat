require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get groups_show_url
    assert_response :success
  end

  test "should get edit" do
    get groups_edit_url
    assert_response :success
  end

  test "should get update" do
    get groups_update_url
    assert_response :success
  end

end
