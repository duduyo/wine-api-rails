require "test_helper"

class Api::V1::WinesControllerTest < ActionDispatch::IntegrationTest

  def setup
    # We do not use fixtures because there creation skips the callbacks
    @vin_de_pays = Wine.create(name: "Vin de pays", price_euros: 9.99, store_url: "https://www.store1.com")
    @beaujolais = Wine.create(name: "Beaujolais", price_euros: 10, store_url: "https://www.store2.com")
    @bourgogne = Wine.create(name: "Bourgogne", price_euros: 30, store_url: "https://www.store2.com")
    @chateau_petrus = Wine.create(name: "Château Petrus", price_euros: 2599.99, store_url: "https://www.store2.com")

    @beaujolais.reviews.create(note: 1, comment: "This is a comment")
    @beaujolais.reviews.create(note: 2, comment: "This is a comment")
    @chateau_petrus.reviews.create(note: 4.9, comment: "This is a comment")
  end

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

  test "should get a wine by id, with no note" do
    get api_v1_wine_url(@vin_de_pays.id)
    assert_equal "Vin de pays", response.parsed_body["name"]
    assert_nil response.parsed_body["note"]
    assert_response :success
  end

  test "should get a wine by id, with a note" do
    get api_v1_wine_url(@beaujolais.id)
    assert_equal "Beaujolais", response.parsed_body["name"]
    assert_equal 1.5, response.parsed_body["note"]
    assert_response :success
  end

end
