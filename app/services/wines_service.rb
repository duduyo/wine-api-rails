# frozen_string_literal: true

class WinesService

  def initialize(notification_service)
   @notification_service = notification_service
  end

  def get_wines(min_price, max_price)
    if min_price && max_price
      wines = Wine.where('price_euros >= ? AND price_euros <= ?', min_price, max_price)
    elsif min_price
      wines = Wine.where('price_euros >= ?', min_price)
    elsif max_price
      wines = Wine.where('price_euros <= ?', max_price)
    else
      wines = Wine.all
    end
    sorted_wines = wines.order('note DESC')
  end

  def add_review_to_wine(wine_id, note, comment)
    wine = Wine.find(wine_id)
    wine.reviews.create(note: note, comment: comment)
  end

  def create_wine(name, price_euros, store_url)
    created_wine = Wine.create(name: name, price_euros: price_euros, store_url: store_url)
    notify_user_if_wine_match_search(created_wine)
    return created_wine
  end

  private

  def notify_user_if_wine_match_search(created_wine)
    Search.find_each do |search|
      search_result = self.get_wines(search.min_price, search.max_price)
      if search_result.map(&:id).include?(created_wine.id)
        @notification_service.notify_user(search.notification_email)
      end
    end
  end

end
