class Review < ApplicationRecord
  belongs_to :user
  has_many :plan_reviews
  has_many :review_items
  # validates :reviewd_on, uniqueness: true
  validates :content, length: { maximum: 200 }
end