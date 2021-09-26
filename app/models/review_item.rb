class ReviewItem < ApplicationRecord
  belongs_to :review
  belongs_to :plan
end
