require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @user = create(:user)
  end

  context "contentがない" do
    it "エラーが出る" do
      review = Review.new(reviewed_on: Date.new(2021, 9, 20), content: nil, user_id: @user.id)
      review.valid?
      expect(review.errors.messages[:content]).to include "を入力してください"
    end
  end

  context "contentが201字文字以上" do
    it "エラーが出る" do
      content = "a" * 201
      review = Review.new(reviewed_on: Date.new(2021, 9, 20), content: content, user_id: @user.id)
      review.valid?
      expect(review.errors.messages[:content]).to include "は200文字以内で入力してください"
    end
  end

  after do
    @user.destroy
  end
end
