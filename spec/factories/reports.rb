FactoryBot.define do
  factory :report do
    reported_on { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    content { "MyString" }
  end
end
