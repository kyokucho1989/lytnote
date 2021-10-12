require 'rails_helper'

# t.references :user, null: false, foreign_key: true
# t.datetime :reported_on
# t.string :content

RSpec.describe Report, type: :model do
  context "reported_onを指定していない" do
    it "エラーが出る" do
      user = User.create!(email: "sasaki@example.com", password: "password")
      report = Report.new(reported_on: nil, content: "忙しかったけど学習できた。", user_id: user.id)
      report.valid?
      expect(report.errors.messages[:reported_on]).to include "を入力してください"
      user.destroy
    end
  end

  context "contentがない" do
    it "エラーが出る" do
      user = User.create!(email: "sasaki@example.com", password: "password")
      report = Report.new(reported_on: Date.new(2021, 9, 20), content: nil, user_id: user.id)
      report.valid?
      expect(report.errors.messages[:content]).to include "を入力してください"
      user.destroy
    end
  end

  context "reported_onが同じ日で存在する（1日1つ)" do
    it "エラーが出る" do
      user = User.create!(email: "sasaki@example.com", password: "password")
      report1 = Report.create!(reported_on: Date.new(2021, 9, 20), content: "よくできた。", user_id: user.id)
      report2 = Report.new(reported_on: Date.new(2021, 9, 20), content: "ふつうだった", user_id: user.id)
      report2.valid?
      expect(report2.errors.messages[:reported_on]).to include "はすでに存在します"
      user.destroy
    end
  end

  context "異なるユーザーのreported_onが同じ日にある" do
    it "エラーが出ない" do
      user1 = User.create!(email: "sasaki@example.com", password: "password")
      user2 = User.create!(email: "andy@example.com", password: "password")
      report1 = Report.create!(reported_on: Date.new(2021, 9, 20), content: "よくできた。", user_id: user1.id)
      report2 = Report.new(reported_on: Date.new(2021, 9, 20), content: "ふつうだった", user_id: user2.id)
      expect(report2.valid?).to eq true
      user1.destroy
      user2.destroy
    end
  end

  context "contentが201文字以上" do
    it "エラーが出る" do
      user = User.create!(email: "sasaki@example.com", password: "password")
      content = "a" * 201
      report = Report.new(reported_on: Date.new(2021, 9, 20), content: content, user_id: user.id)
      report.valid?
      expect(report.errors.messages[:content]).to include "は200文字以内で入力してください"
      user.destroy
    end
  end
end
