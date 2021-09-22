class PlanReviewRecord < ApplicationRecord
  belongs_to :plan
  belongs_to :review
  belongs_to :genre
end
