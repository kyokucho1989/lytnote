FactoryBot.define do
  factory :plan do
    user { nil }
    genre { nil }
    name { "MyString" }
    deadline { Date.today.since(10.days) }
    status { "進行中" }
  end
end
