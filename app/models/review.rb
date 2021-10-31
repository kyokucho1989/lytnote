class Review < ApplicationRecord
  belongs_to :user
  has_many :review_items
  accepts_nested_attributes_for :review_items
  validates :reviewed_on, presence: true
  # validates :reviewd_on, uniqueness: true
  validates :content, length: { maximum: 200 }, presence: true

  def self.convert_content_shared(formatted_para, genres_set)
    date = formatted_para[:reported_on]
    items = formatted_para[:report_items_attributes].values
    binding.pry
    formatted_items = ""
    items.each do |item|
      genre_name = genres_set.assoc(item[:genre_id].to_i).last
      formatted_items = formatted_items + "【" + genre_name + "】" + item[:content] + "   " + item[:work_hours] + "時間 \n"
    end
    content = formatted_para[:content]
    date + "\n" + formatted_items + "\n" + content
  end
end
