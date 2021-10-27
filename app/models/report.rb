class Report < ApplicationRecord
  belongs_to :user
  has_many :report_items, dependent: :destroy
  accepts_nested_attributes_for :report_items
  validates :reported_on, presence: true, uniqueness: { scope: :user }
  validates :content, length: { maximum: 200 }, presence: true
  validates :content_for_share, length: { maximum: 200 }


  def self.convert_content_shared(formatted_para)
    date = formatted_para[:reported_on]
    items = formatted_para[:report_items_attributes].values
    formatted_items = ""
    items.each do |item|
      formatted_items = formatted_items + "【やったこと】" + item[:content] + " 【ジャンル】" + item[:genre_id] + "【やった時間】" + item[:work_hours] + "時間 \n" 
    end
    content = formatted_para[:content]
    binding.pry
    share_content = date + formatted_items + content
    share_content
  end
end
