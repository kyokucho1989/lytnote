class ReviewItem < ApplicationRecord
  belongs_to :review
  belongs_to :plan
  validates_acceptance_of :plan_check
end
