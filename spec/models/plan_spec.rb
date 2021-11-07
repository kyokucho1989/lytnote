require 'rails_helper'

RSpec.describe Plan, type: :model do
  before do
    @user = create(:user)
    @genre = create(:genre, user: @user)
  end

  context "nameが空白" do
    it "エラーが出る" do
      plan =  Plan.new(name: nil, user_id: @user.id, genre_id: @genre.id,\
              deadline: Date.today + 1, status: "進行中")
      plan.valid?
      expect(plan.errors.messages[:name]).to include "を入力してください"
    end
  end

  context "nameが21文字以上" do
    it "エラーが出る" do
      plan =  Plan.new(name: "a"*21, user_id: @user.id, genre_id: @genre.id,\
              deadline: Date.today + 1, status: "進行中")
      plan.valid?
      expect(plan.errors.messages[:name]).to include "は20文字以内で入力してください"
    end
  end

  context "deadlineが今日より前　かつ　statusが進行中" do
    it "エラーが出る" do
      plan =  Plan.new(name: "参考書20ページ進める", user_id: @user.id, genre_id: @genre.id,\
              deadline: Date.today - 1, status: "進行中")
      plan.valid?
      expect(plan.errors.messages[:deadline]).to include "過去の日付は使えません"
    end
  end

  context "deadlineが今日より前　かつ　statusが進行中以外" do
    it "エラーが出ない" do
      plan =  Plan.new(name: "参考書20ページ進める", user_id: @user.id, genre_id: @genre.id,\
              deadline: Date.today - 1, status: "完了")
      plan.valid?
      expect(plan.valid?).to eq true
    end
  end

  after do
    @user.destroy
    @genre.destroy
  end
end
