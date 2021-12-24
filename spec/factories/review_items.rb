FactoryBot.define do
  factory :review_item do
    user { nil }
    review { nil }
    genre { nil }
    deadline { Faker::Date.between(from: 2.days.later, to: 10.days.later) }
  end
end
