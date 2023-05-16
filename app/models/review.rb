class Review < ApplicationRecord
  belongs_to :user
  has_many :review_items, dependent: :destroy
  accepts_nested_attributes_for :review_items
  validates :reviewed_on, presence: true, uniqueness: { scope: :user }
  validates :content, length: { maximum: 200 }, presence: true
  validate :cannot_set_over_2_times_per_week

  def cannot_set_over_2_times_per_week
    query = user.reviews.where(reviewed_on: reviewed_on.beginning_of_week..reviewed_on.end_of_week)
    query = query.where.not(id: id) if persisted?
    errors.add(:reviewed_on, ":振り返りは週に1回までです") if query.exists?
  end

  def self.convert_content_shared(before_plan_state, after_plan_state, review_params, genres_set)
    date = review_params[:reviewed_on]
    content = review_params[:content]
    # binding.pry
    formatted_items = ""
    (0...before_plan_state.size).each do |i|
      genre_id = before_plan_state[i].genre_id
      genre_name = if genre_id.to_s.empty?
                     item[:genre_id].to_s
                   else
                     genres_set.assoc(genre_id).last
                   end

      name = before_plan_state[i].name
      before_state = before_plan_state[i].status
      before_deadline = before_plan_state[i].deadline.strftime("%m/%d")
      after_state = after_plan_state[i].status
      after_deadline = after_plan_state[i].deadline.strftime("%m/%d")
      formatted_items = if after_state == "進行中"
                          formatted_items + "【" + genre_name + "】" + name + " 締め切り" + before_deadline + "→" + after_state + " 期日 " + after_deadline + "に延長" + " \n"
                        else
                          formatted_items + "【" + genre_name + "】" + name + " 締め切り" + before_deadline + "→" + after_state + " \n"
                        end
    end

    date + "\n" + formatted_items + "\n" + content
  end
end
