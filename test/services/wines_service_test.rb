require "test_helper"
require 'minitest/autorun'

class WineServiceTest < ActiveSupport::TestCase

  test "Should create wine and notify user" do

    # given
    notification_service = Minitest::Mock.new
    wines_service = WinesService.new(notification_service)
    Search.create(min_price: 10, max_price: 20, notification_email: "user_to_notify@mail.com")
    Search.create(min_price: 15, max_price: 20, notification_email: "user_not_to_notify@mail.com")
    notification_service.expect :notify_user, nil, ['user_to_notify@mail.com']

    # when
    wines_service.create_wine("Chateau de la tour", 12.5, "http://www.lavinia.fr")

    # then
    notification_service.verify

  end


end