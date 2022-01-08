FactoryBot.define do
  factory :review do
    content { "MyString" }
    user { nil }
    sequence(:reviewed_on) { |i| Date.today.since(i.days) }
  end
end
