require 'test_helper'

class RentConditionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rent_condition_index_url
    assert_response :success
  end

  test "should get show" do
    get rent_condition_show_url
    assert_response :success
  end

end
