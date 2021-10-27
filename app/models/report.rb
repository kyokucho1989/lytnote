class Report < ApplicationRecord
  belongs_to :user
  has_many :report_items, dependent: :destroy
  accepts_nested_attributes_for :report_items
  validates :reported_on, presence: true, uniqueness: { scope: :user }
  validates :content, length: { maximum: 200 }, presence: true
  validates :content_for_share, length: { maximum: 200 }


  def self.convert_content_shared(formatted_para)
    date = formatted_para[:reported_on]
    items = formatted_para[:report_items_attributes]
    content = formatted_para[:content]
    binding.pry
    share_content = date + items + content
    share_content
  end
end
