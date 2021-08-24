class UserDailyComment < ApplicationRecord
  belongs_to :user
  has_many :done_lists, dependent: :destroy
end
