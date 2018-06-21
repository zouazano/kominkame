require 'test_helper'

class RentPrefecturesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rent_prefectures_index_url
    assert_response :success
  end

  test "should get show" do
    get rent_prefectures_show_url
    assert_response :success
  end

end
