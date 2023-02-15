require "test_helper"

class Public::DetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_details_new_url
    assert_response :success
  end

  test "should get index" do
    get public_details_index_url
    assert_response :success
  end

  test "should get show" do
    get public_details_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_details_edit_url
    assert_response :success
  end

  test "should get create" do
    get public_details_create_url
    assert_response :success
  end

  test "should get update" do
    get public_details_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_details_destroy_url
    assert_response :success
  end
end
