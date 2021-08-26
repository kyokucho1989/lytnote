FactoryBot.define do
  factory :plan do
    user { nil }
    genre { nil }
    name { "MyString" }
    created_on { "2021-08-26 05:54:30" }
    deadline { "2021-08-26 05:54:30" }
    status { "MyString" }
  end
end
