class PlanList < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :status
  has_many :plan_review_lists
end
