class Review < ApplicationRecord
  belongs_to :user
  has_many :plan_reviews
  has_many :linked_plans, through: :plan_reviews, source: :plan
  validates :created_on, uniqueness: true
  validates :content, length: { maximum: 200 }
end
