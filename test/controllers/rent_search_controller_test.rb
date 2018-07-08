require 'test_helper'

class RentSearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rent_search_index_url
    assert_response :success
  end

end
