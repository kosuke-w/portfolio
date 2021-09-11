require 'test_helper'

class CoordinatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get coordinates_new_url
    assert_response :success
  end

  test "should get index" do
    get coordinates_index_url
    assert_response :success
  end

  test "should get edit" do
    get coordinates_edit_url
    assert_response :success
  end

  test "should get show" do
    get coordinates_show_url
    assert_response :success
  end

end
