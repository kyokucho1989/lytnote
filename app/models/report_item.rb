class ReportItem < ApplicationRecord
  belongs_to :report
  validates :content, length: { maximum: 20 }
  validates :work_hours, numericality: {greater_than: 0, less_than_or_equal_to: 24} 
end
