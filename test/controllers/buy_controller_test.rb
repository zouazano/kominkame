# frozen_string_literal: true

require 'test_helper'

class BuyControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get buy_index_url
    assert_response :success
  end

  test 'should get show' do
    get buy_show_url
    assert_response :success
  end
end
