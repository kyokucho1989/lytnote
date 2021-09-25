class ReviewItem < ApplicationRecord
  belongs_to :review
  belongs_to :genre
  belongs_to :plan
end
