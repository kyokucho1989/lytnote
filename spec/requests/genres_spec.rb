require 'rails_helper'

# genres      GET     /genres(.:format)           genres#index
#             POST    /genres(.:format)           genres#create
# new_genre   GET     /genres/new(.:format)       genres#new
# edit_genre  GET     /genres/:id/edit(.:format)  genres#edit
# genre       PATCH   /genres/:id(.:format)       genres#update
#             PUT     /genres/:id(.:format)       genres#update
#             DELETE  /genres/:id(.:format)       genres#destroy

RSpec.describe "Genres", type: :request do
  describe "GET /genres" do
    subject { get(genres_path) }
    before do
      @user = create(:user)
      sign_in @user
    end
    it "ジャンル一覧が取得できる" do
      subject
      binding.pry
    end
  end

  describe "POST /genres" do
    it "ジャンルのレコードが作成できる" do
    end
  end

  describe "PATCH /genres/:id" do
    it "任意のレコードを更新できる" do
    end
  end

  describe "DELETE/genres/:id" do
    it "任意のレコードを削除できる" do
    end
  end
end
