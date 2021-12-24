FactoryBot.define do
  factory :report do
    sequence(:reported_on) { |i| Date.today.since(i.days) }
    content { "MyString" }
  end
end
