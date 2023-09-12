require "test_helper"

class WineServiceTest < ActiveSupport::TestCase


  test "Should create wine" do
    wines_service = WinesService.new
    wine = wines_service.create_wine("Chateau de la tour", 12.5, "http://www.lavinia.fr")
    assert_equal(12.5, wine.price_euros)
  end


end