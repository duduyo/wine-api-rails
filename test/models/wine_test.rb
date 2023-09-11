require "test_helper"

class WineTest < ActiveSupport::TestCase
  def setup
    @wine = Wine.create(name: "Chateau de la tour", price_euros: 12.5, store_url: "http://www.lavinia.fr")
  end

  test "The note of a wine with no review should be nil" do
    assert_nil(@wine.note)
  end

  test "The note of a wine with reviews should be equal to the average note of reviews" do
    @wine.reviews.create(note: 1, comment: "This is a comment")
    @wine.reviews.create(note: 2, comment: "This is a comment")
    assert_equal(1.5, @wine.note)
  end
end
