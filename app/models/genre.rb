class Genre < ApplicationRecord
  has_many :report_items, dependent: :restrict_with_error
  has_many :plans, dependent: :restrict_with_error
  belongs_to :user
  validates :name, length: { maximum: 20 }, uniqueness: { scope: :user }, presence: true
end
