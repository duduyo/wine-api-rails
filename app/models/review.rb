class Review < ApplicationRecord
  belongs_to :wine
  validates :note, presence: true, inclusion: { in: 0..5 }
  validates :comment, presence: true
end
