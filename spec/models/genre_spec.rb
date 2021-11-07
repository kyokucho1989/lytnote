require 'rails_helper'

RSpec.describe Genre, type: :model do
  before do
    @user = create(:user)
    @user2 = create(:user)
  end

  context "nameが空白" do
    it "エラーが出る" do
      genre = Genre.new(name: nil, user_id: @user.id)
      genre.valid?
      expect(genre.errors.messages[:name]).to include "を入力してください"
    end
  end

  context "nameが21文字以上" do
    it "エラーが出る" do
      genre = Genre.new(name: "a" * 21, user_id: @user.id)
      genre.valid?

      expect(genre.errors.messages[:name]).to include "は20文字以内で入力してください"
    end
  end

  context "同じユーザーの中でnameが重複している" do
    it "エラーが出る" do
      genre = Genre.create!(name: "test", user_id: @user.id)
      genre2 = Genre.new(name: "test", user_id: @user.id)
      genre2.valid?
      expect(genre2.errors.messages[:name]).to include "はすでに存在します"
    end
  end

  context "異なるユーザーでnameが重複している" do
    it "エラーが出ない" do
      genre1 = Genre.create!(name: "test", user_id: @user.id)
      genre2 = Genre.new(name: "test", user_id: @user2.id)
      genre2.valid?
      expect(genre2.valid?).to eq true
    end
  end

  after do
    @user.destroy
    @user2.destroy
  end
end
