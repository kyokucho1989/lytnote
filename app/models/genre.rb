class Genre < ApplicationRecord
  has_many :report_items
  has_many :plans
  validates :name, length: { maximum: 10 }
end
