# frozen_string_literal: true

class WinesService

  def initialize(notification_service)
   @notification_service = notification_service
  end

  def create_wine(name, price_euros, store_url)
    created_wine = Wine.create(name: name, price_euros: price_euros, store_url: store_url)
    notify_user_if_wine_match_search(created_wine)
    return created_wine
  end

  private

  def notify_user_if_wine_match_search(created_wine)
    Search.find_each do |search|
      if search.min_price <= created_wine.price_euros && search.max_price >= created_wine.price_euros
        @notification_service.notify_user(search.notification_email)
      end
    end
  end

end
