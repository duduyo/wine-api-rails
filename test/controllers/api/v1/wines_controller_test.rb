require "test_helper"

class Api::V1::WinesControllerTest < ActionDispatch::IntegrationTest

  test "should get all wines" do
    get api_v1_wines_url
    assert_response :success
    assert_equal 4, response.parsed_body.length
  end

  test "should get wines with price geater than or equal to min_price" do
    get api_v1_wines_url, params: { min_price: 10 }
    assert_response :success
    assert_equal 3, response.parsed_body.length
    assert response.parsed_body.all? { |wine| wine["price_euros"] >= 10 }
  end

  test "should get wines with price lower than or equal to max_price" do
    get api_v1_wines_url, params: { max_price: 30 }
    assert_response :success
    assert_equal 3, response.parsed_body.length
    assert response.parsed_body.all? { |wine| wine["price_euros"] <= 30 }
  end

  test "should get wines with price between min_price and max_price" do
    get api_v1_wines_url, params: { min_price: 10, max_price: 30 }
    assert_response :success
    assert_equal 2, response.parsed_body.length
    assert response.parsed_body.all? { |wine| wine["price_euros"] >= 10 && wine["price_euros"] <= 30 }
  end

  test "should get a wine by id" do
    get api_v1_wine_url(wines(:one).id)
    assert_equal "Vin de pays", response.parsed_body["name"]
    assert_response :success
  end

end
