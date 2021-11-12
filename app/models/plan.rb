class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :review_items, dependent: :restrict_with_error
  accepts_nested_attributes_for :review_items
  validates :deadline, presence: true
  validate :deadline_cannot_set_in_past
  validates :name, length: { maximum: 20 }, presence: true
  def deadline_cannot_set_in_past
    errors.add(:deadline, " :ステータスが「進行中」の場合、過去の日付は使えません") if status == "進行中" && (deadline.present? && deadline < Date.today)
  end
end
