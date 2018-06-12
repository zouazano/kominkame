require 'test_helper'

class RentControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rent_index_url
    assert_response :success
  end

  test "should get show" do
    get rent_show_url
    assert_response :success
  end

end
