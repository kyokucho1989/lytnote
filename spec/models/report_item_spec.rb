require 'rails_helper'

RSpec.describe ReportItem, type: :model do
  before do 
    @user = User.create!(email: "sasaki@example.com", password: "password")
    @report = Report.create!(reported_on: Date.new(2021, 9, 20), content: "忙しかったけど学習できた。", user_id: @user.id)
    @genre = Genre.create!(name: "英語学習", user_id: @user.id)
  end

  context "contentがない" do
    it "エラーが出る" do
      report_item = ReportItem.new(content: nil, report_id: @report.id,genre_id: @genre.id, work_hours:2.5)
      report_item.valid?
      expect(report_item.errors.messages[:content]).to include "を入力してください"
    end

  end

  context "contentが21文字以上" do
    it "エラーが出る" do
      content = "a" *21
      report_item = ReportItem.new(content: content, report_id: @report.id,genre_id: @genre.id, work_hours:2.5)
      report_item.valid?
      expect(report_item.errors.messages[:content]).to include "は20文字以内で入力してください"
    end
  end

  context "work_hoursがない" do
    it "エラーが出る" do
      report_item = ReportItem.new(content: "TOEIC　問題集", report_id: @report.id,genre_id: @genre.id, work_hours:nil)
      report_item.valid?
      expect(report_item.errors.messages[:work_hours]).to include "を入力してください"
    end
  end

  context "work_hoursが数字以外" do
    it "エラーが出る" do
      report_item = ReportItem.new(content: "TOEIC　問題集", report_id: @report.id,genre_id: @genre.id, work_hours:"テスト")
      report_item.valid?
      expect(report_item.errors.messages[:work_hours]).to include "は数値で入力してください"
    end
  end

  context "work_hoursが5文字以上" do
    it "エラーが出る" do
      report_item = ReportItem.new(content: "TOEIC　問題集", report_id: @report.id,genre_id: @genre.id, work_hours:12.23)
      report_item.valid?
      expect(report_item.errors.messages[:work_hours]).to include "は4文字以内で入力してください"
    end
  end
end
