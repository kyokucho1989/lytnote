require 'rails_helper'

# t.references :user, null: false, foreign_key: true
# t.datetime :reported_on
# t.string :content

RSpec.describe Report, type: :model do
  context "reported_onを指定していない" do
    it "エラーが出る" do
      user = User.new(email: "satou@example.com", password: "password")
      report = Report.new(reported_on:nil,content: "忙しかったけど学習できた。",user_id:user.id)
      report.valid?
      expect(report.errors.messages[:user]).to include "を入力してください"
    end
  end

  context "contentがない" do
    it "エラーが出る" do
    end
  end

  context "reported_onが同じ日で存在する（1日1つ)" do
    it "エラーが出る" do
    end
  end
end
