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
  before do

    sign_in user
    create_list(:genre, 3, user: user)
  end

  describe "GET /genres" do
    subject { get(genres_path( :format => :json )) }
    it "ジャンル一覧が取得できる" do
      subject
      res = JSON.parse(response.body)
      # binding.pry
      expect(res["genres"].size).to eq 3
      expect(res["genres"].first.keys).to eq ["id", "name"]
      expect(response).to have_http_status(200) 
    end
  end

  describe "POST /genres" do

    subject { post(genres_path( :format => :json ), params: params) }
    let(:params) { {genre: attributes_for(:genre) }}

    it "ジャンルのレコードが作成できる" do
      binding.pry
      expect { subject }.to change { Genre.count }.by(1)
      expect(response).to have_http_status(200) 
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
