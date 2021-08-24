FactoryBot.define do
  factory :done_list do
    content { "MyString" }
    user_daily_comment { nil }
    genre { "" }
    work_hours { 1.5 }
  end
end
