class Wine < ApplicationRecord
  # Force load of reviews when loading a wine
  # https://guides.rubyonrails.org/association_basics.html#eager-loading-associations
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :price_euros, presence: true
  validates :store_url, presence: true

  def note
    return nil if reviews.empty?
    reviews.average(:note).round(1)
  end

end
