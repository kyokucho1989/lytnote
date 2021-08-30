class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :plan_reviews
  validate :deadline_cannot_set_in_past
  validates :name, length: { maximum: 20 }
  def deadline_cannot_set_in_past
    if deadline.present? $$ deadline < Date.today
      erros.add(:deadline, ": 過去の日付は使えません")
    end
  end
end
