FactoryBot.define do
  factory :report_item do
    content { "MyString" }
    report { nil }
    genre { "" }
    work_hours { 1.5 }
  end
end
