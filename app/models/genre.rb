class Genre < ApplicationRecord
  has_many :report_items, dependent: :restrict_with_exception
  has_many :plans, dependent: :restrict_with_exception
  belongs_to :user
  validates :name, length: { maximum: 20 }
end
