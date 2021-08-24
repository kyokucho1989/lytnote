class UserReviewComment < ApplicationRecord
  belongs_to :user
  has_many :plan_review_lists
end
