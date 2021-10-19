class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :review_items, dependent: :restrict_with_error
  accepts_nested_attributes_for :review_items
  validate :deadline_cannot_set_in_past
  validates :name, length: { maximum: 20 }
  def deadline_cannot_set_in_past
    errors.add(:deadline, ": 過去の日付は使えません") if deadline.present? && deadline < Date.today
  end
end
