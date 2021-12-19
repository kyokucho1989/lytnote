require 'rails_helper'

# genres      GET     /genres(.:format)           genres#index
#             POST    /genres(.:format)           genres#create
# new_genre   GET     /genres/new(.:format)       genres#new
# edit_genre  GET     /genres/:id/edit(.:format)  genres#edit
# genre       PATCH   /genres/:id(.:format)       genres#update
#             PUT     /genres/:id(.:format)       genres#update
#             DELETE  /genres/:id(.:format)       genres#destroy

RSpec.describe "Genres", type: :request do
  let(:user) { create(:user) }
  let(:genre_count){3}
  before do
    sign_in user
    # genre_count = 3
    create_list(:genre, genre_count, user: user)
  end

  describe "GET /genres" do
    subject { get(genres_path( :format => :json )) }
    it "ジャンル一覧が取得できる" do
      subject
      res = JSON.parse(response.body)
      got_genre_count = res["genres"].size
      expect(got_genre_count).to eq genre_count
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

  after do
    user.destroy
  end
end
