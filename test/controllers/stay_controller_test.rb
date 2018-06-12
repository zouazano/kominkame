require 'test_helper'

class StayControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stay_index_url
    assert_response :success
  end

  test "should get show" do
    get stay_show_url
    assert_response :success
  end

end
