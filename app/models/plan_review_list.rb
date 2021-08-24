class PlanReviewList < ApplicationRecord
  belongs_to :plan_list
  belongs_to :user_review_comment
end
