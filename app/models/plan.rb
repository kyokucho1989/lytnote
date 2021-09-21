class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :plan_reviews
  has_many :linked_reviews, through: :plan_reviews, source: :review
  validate :deadline_cannot_set_in_past
  validates :name, length: { maximum: 20 }
  def deadline_cannot_set_in_past
    errors.add(:deadline, ": 過去の日付は使えません") if deadline.present? && deadline < Date.today
  end
end
