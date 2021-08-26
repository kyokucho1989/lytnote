class PlanReview < ApplicationRecord
  belongs_to :plan
  belongs_to :review
end
