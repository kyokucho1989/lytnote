class Report < ApplicationRecord
  belongs_to :user
  has_many :report_items, dependent: :destroy
  accepts_nested_attributes_for :report_items
  validates :reported_on, presence: true, uniqueness: { scope: :user }
  validates :content, length: { maximum: 200 }, presence: true
  validates :content_for_share, length: { maximum: 200 }


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
    share_content = date + "\n" + formatted_items + "\n" + content
    share_content
  end

  # def self.get_genre_name(genre_id,current_user)
  #   @genres = Genre.where(user_id: current_user.id)
  #   @genres.where(id: genre_id).first[:name]
  # end
end
