class ReportItem < ApplicationRecord
  belongs_to :report
  belongs_to :genre
  validates :content, length: { maximum: 20 }, presence: true
  validates :work_hours, numericality: { greater_than: 0, less_than_or_equal_to: 24 }, length: { maximum: 4 }, presence: true
end
