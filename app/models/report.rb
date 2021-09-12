class Report < ApplicationRecord
  belongs_to :user
  has_many :report_items
  accepts_nested_attributes_for :report_items
  validates :created_on, uniqueness: true
  validates :content, length: { maximum: 200 }
end