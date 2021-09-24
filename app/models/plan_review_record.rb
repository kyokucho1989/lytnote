class PlanReviewRecord < ApplicationRecord
  belongs_to :plan
  belongs_to :review
  # belongs_to :genre
  validates :name, length: { maximum: 20 }
  validates :status, length: { maximum: 20 }
  validates :status_after_review, length: { maximum: 20 }
  binding.pry
  validate :plan_review_created_in_same_user

  #　バリデーション　planとreviewが同一ユーザーであること
  #  review_on が plan_seton　より後であること
  #  同一planに対するreviewがすでにあり、なおかつそのreview_onのほうが後であるとき 

  def plan_review_created_in_same_user
    if plan_id && expiration_date < Date.today
      errors.add(:plan_id, ": 同一ユーザーではありません")
    end
  end

end
