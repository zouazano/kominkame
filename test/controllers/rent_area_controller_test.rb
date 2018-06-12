require 'test_helper'

class RentAreaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rent_area_index_url
    assert_response :success
  end

  test "should get show" do
    get rent_area_show_url
    assert_response :success
  end

end
