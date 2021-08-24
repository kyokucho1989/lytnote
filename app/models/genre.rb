class Genre < ApplicationRecord
  has_many :done_lists
  has_many :plan_lists
end
