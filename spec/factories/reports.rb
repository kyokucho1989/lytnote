FactoryBot.define do
  factory :report do
    user { nil }
    created_on {Faker::Date.between(from: 2.days.ago, to: Date.today)}
    content { "MyString" }
  end
end
