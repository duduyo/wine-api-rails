require "test_helper"

class Api::V1::WinesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should get all wines" do
    get api_v1_wines_url
    assert_response :success
    assert_equal 2, response.parsed_body.length
  end

  test "should get a wine by id" do
    get api_v1_wine_url(wines(:one).id)
    assert_equal "Château 1", response.parsed_body["name"]
    assert_response :success
  end

end
