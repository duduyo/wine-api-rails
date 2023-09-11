class Wine < ApplicationRecord
  # Force load of reviews when loading a wine
  # https://guides.rubyonrails.org/association_basics.html#eager-loading-associations
  has_many :reviews, dependent: :destroy, after_add: :set_wine_note

  validates :name, presence: true
  validates :price_euros, presence: true
  validates :store_url, presence: true

  def set_wine_note(review)
    if reviews.empty?
      self.note = nil
    else
      self.note = calculate_reviews_average_note
    end
    save
  end

  private

  def calculate_reviews_average_note
    review_notes = reviews.map(&:note)
    return (review_notes.sum / review_notes.size).round(1)
  end

end
