# frozen_string_literal: true

class WinesService

  def create_wine(name, price_euros, store_url)
    return Wine.create(name: name, price_euros: price_euros, store_url: store_url)
  end

end
