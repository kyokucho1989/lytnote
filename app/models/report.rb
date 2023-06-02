class Report < ApplicationRecord
  belongs_to :user
  has_many :report_items, dependent: :destroy
  accepts_nested_attributes_for :report_items
  validates :reported_on, presence: true, uniqueness: { scope: :user }
  validates :content, length: { maximum: 200 }, presence: true
  validates :content_for_share, length: { maximum: 200 }
  # validate :report_items_donot_have_one_also
  # def report_items_donot_have_one_also
  #   errors.add(:report_items, "やったことは少なくてもひとつ必要です") if report_items.size < 1
  # end

  def self.convert_content_shared(formatted_para, genres_set)
    date = formatted_para[:reported_on]
    items = formatted_para[:report_items_attributes].values
    formatted_items = ""
    items.each do |item|
      if item[:genre_id].to_s.empty?
        genre_name = item[:genre_id].to_s
      else
        genre_name = genres_set.assoc(item[:genre_id].to_i).last.to_s
      end
      formatted_items = formatted_items + "【" + genre_name + "】" + item[:content] + "   \n"
    end
    content = formatted_para[:content]
    date + "\n" + formatted_items + "\n" + content
  end
end
