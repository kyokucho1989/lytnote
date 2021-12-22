FactoryBot.define do
  max_length = 20
  factory :genre do
    name { Faker::Educator.subject.slice(0, max_length - 1)+rand(1..100).to_s }
  end
end
