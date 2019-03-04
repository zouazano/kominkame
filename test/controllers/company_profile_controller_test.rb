require 'test_helper'

class CompanyProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get company_profile_index_url
    assert_response :success
  end

end
