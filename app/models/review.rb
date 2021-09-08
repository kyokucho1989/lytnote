class Review < ApplicationRecord
  belongs_to :user
  has_many :plan_reviews
  validates :created_on, uniqueness: true
  validates :content, length: { maximum: 200 }
end
