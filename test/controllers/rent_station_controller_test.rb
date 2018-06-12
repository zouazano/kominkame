require 'test_helper'

class RentStationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rent_station_index_url
    assert_response :success
  end

  test "should get show" do
    get rent_station_show_url
    assert_response :success
  end

end
