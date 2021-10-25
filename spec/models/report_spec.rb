require 'rails_helper'

RSpec.describe Report, type: :model do
  before do
    @user = create(:user)
    @user2 = create(:user)
  end

  context "reported_onを指定していない" do
    it "エラーが出る" do
      report = Report.new(reported_on: nil, content: "忙しかったけど学習できた。", user_id: @user.id)
      report.valid?
      expect(report.errors.messages[:reported_on]).to include "を入力してください"
    end
  end

  context "contentがない" do
    it "エラーが出る" do
      report = Report.new(reported_on: Date.new(2021, 9, 20), content: nil, user_id: @user.id)
      report.valid?
      expect(report.errors.messages[:content]).to include "を入力してください"
    end
  end

  context "reported_onが同じ日で存在する（1日1つ)" do
    it "エラーが出る" do
      report1 = Report.create!(reported_on: Date.new(2021, 9, 20), content: "よくできた。", user_id: @user.id)
      report2 = Report.new(reported_on: Date.new(2021, 9, 20), content: "ふつうだった", user_id: @user.id)
      report2.valid?
      expect(report2.errors.messages[:reported_on]).to include "はすでに存在します"
    end
  end

  context "異なるユーザーのreported_onが同じ日にある" do
    it "エラーが出ない" do
      report1 = Report.create!(reported_on: Date.new(2021, 9, 20), content: "よくできた。", user_id: @user.id)
      report2 = Report.new(reported_on: Date.new(2021, 9, 20), content: "ふつうだった", user_id: @user2.id)
      expect(report2.valid?).to eq true
    end
  end

  context "contentが201文字以上" do
    it "エラーが出る" do
      content = "a" * 201
      report = Report.new(reported_on: Date.new(2021, 9, 20), content: content, user_id: @user.id)
      report.valid?
      expect(report.errors.messages[:content]).to include "は200文字以内で入力してください"
    end
  end

  after do
    @user.destroy
    @user2.destroy
  end
end
