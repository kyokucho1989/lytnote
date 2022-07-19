class Genre < ApplicationRecord
  has_many :report_items, dependent: :nullify
  has_many :plans, dependent: :nullify
  belongs_to :user
  validates :name, length: { maximum: 20 }, uniqueness: { scope: :user }, presence: true
end
