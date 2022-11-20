class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :genre, optional: true
  has_many :review_items, dependent: :restrict_with_error
  accepts_nested_attributes_for :review_items
  validates :deadline, presence: true
  validate :deadline_cannot_set_in_past
  validate :cannot_edit_on_complete, on: :update
  validate :progress_total_count_cannot_set_exceeded_limit
  validates :name, length: { maximum: 20 }, presence: true

  PROGRESS_MAX_COUNT = 3
  def progress_total_count_cannot_set_exceeded_limit
    count_in_progress = user.plans.where(status: "進行中").count
    if count_in_progress > PROGRESS_MAX_COUNT
      errors.add(:status, ":「進行中」の目標の数は、3個までです") 
    end
  end

  def deadline_cannot_set_in_past
    errors.add(:deadline, ":ステータスが「進行中」の場合、過去の日付は使えません") if status == "進行中" && (deadline.present? && deadline < Date.today)
  end

  def cannot_edit_on_complete
    if status == "完了" && (deadline_changed? || name_changed?)
      errors.add(:deadline, ":完了状態で締め切りは変更できません") 
    end
  end
end
