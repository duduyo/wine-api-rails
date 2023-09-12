require "test_helper"
require 'minitest/autorun'

class WineServiceTest < ActiveSupport::TestCase

  def setup
    # We do not use fixtures because there creation skips the callbacks
    @vin_de_pays = Wine.create(name: "Vin de pays", price_euros: 9.99, store_url: "https://www.store1.com")
    @beaujolais = Wine.create(name: "Beaujolais", price_euros: 10, store_url: "https://www.store2.com")
    @bourgogne = Wine.create(name: "Bourgogne", price_euros: 30, store_url: "https://www.store2.com")
    @chateau_petrus = Wine.create(name: "Château Petrus", price_euros: 2599.99, store_url: "https://www.store2.com")

    @beaujolais.reviews.create(note: 1, comment: "This is a comment")
    @beaujolais.reviews.create(note: 2, comment: "This is a comment")
    @chateau_petrus.reviews.create(note: 4.9, comment: "This is a comment")

    @notification_service = Minitest::Mock.new
    @wines_service = WinesService.new(@notification_service)
  end

  test "Should create wine and notify user" do
    # given

    Search.create(min_price: 100, max_price: 200, notification_email: "notified_user@mail.com")
    Search.create(min_price: 500, max_price: 600, notification_email: "other_user@mail.com")
    @notification_service.expect :notify_user, nil, ['notified_user@mail.com']

    # when
    @wines_service.create_wine("Chateau de la tour", 150, "http://www.lavinia.fr")
    # then
    @notification_service.verify

  end


  test "should get all wines" do
    wines = @wines_service.get_wines(nil, nil)
    assert_equal 4, wines.length
  end

  test "should get wines with price geater than or equal to min_price" do
    wines = @wines_service.get_wines(10, nil)
    assert_equal 3, wines.length
    assert wines.all? { |wine| wine["price_euros"] >= 10 }
  end

  test "should get wines with price lower than or equal to max_price" do
    wines = @wines_service.get_wines(nil, 30)
    assert_equal 3, wines.length
    assert wines.all? { |wine| wine["price_euros"] <= 30 }
  end

  test "should get wines with price between min_price and max_price" do
    wines = @wines_service.get_wines(10, 30)
    assert_equal 2, wines.length
    assert wines.all? { |wine| wine["price_euros"] >= 10 && wine["price_euros"] <= 30 }
  end

end