require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get valid page" do
    params = {
      page: "about"
      }
    get pages_url params
    assert_response :success
  end

  test "should give 404 for invalid page" do
    params = {
      page: "foo"
    }
    get pages_url params
    assert_response 404
  end

end
