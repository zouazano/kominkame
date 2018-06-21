require 'test_helper'

class RentPrefectureControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rent_prefecture_index_url
    assert_response :success
  end

  test "should get show" do
    get rent_prefecture_show_url
    assert_response :success
  end

end
