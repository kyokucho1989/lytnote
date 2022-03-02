class ReviewItem < ApplicationRecord
  belongs_to :review
  belongs_to :plan
  validates :plan_check, acceptance: true
end
