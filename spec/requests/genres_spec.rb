require 'rails_helper'

# genres      GET     /genres(.:format)           genres#index
#             POST    /genres(.:format)           genres#create
# new_genre   GET     /genres/new(.:format)       genres#new
# edit_genre  GET     /genres/:id/edit(.:format)  genres#edit
# genre       PATCH   /genres/:id(.:format)       genres#update
#             PUT     /genres/:id(.:format)       genres#update
#             DELETE  /genres/:id(.:format)       genres#destroy

RSpec.describe "Genres", type: :request do
  # let(:user) { create(:user) }

  before(:context) do
    @user = create(:user)
    create_list(:genre, 3, user: @user)
  end

  before(:example) do
    sign_in @user
  end

  after(:example) do
    sign_out @user
  end

  after(:context) do
    @user.destroy
  end
  
  describe "GET /genres" do
    subject { get(genres_path( :format => :json )) }
    it "ジャンル一覧が取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res["genres"].size).to eq 3
      expect(res["genres"].first.keys).to eq ["id", "name"]
      expect(response).to have_http_status(200) 
    end
  end

  describe "POST /genres" do
    subject { post(genres_path( :format => :json ), params: params) }
    let(:params) { {genre: attributes_for(:genre) }}
    it "ジャンルのレコードが作成できる" do
      expect { subject }.to change { Genre.count }.by(1)
      expect(response).to have_http_status(200) 
    end
  end

  describe "PUT /genres/:id" do

    subject { put(genre_path(genre.id, :format => :json ), params: params) }
    let(:params) { { genre: { name: Faker::Name.name, created_at: Time.current } } }
    let(:genre) { create(:genre, user: @user) }
    it "任意のレコードを更新できる" do
      # binding.pry
      expect { subject }.to change { Genre.find(genre.id).name }.from(genre.name).to(params[:genre][:name]) &
      not_change { Genre.find(genre.id).created_at }
      expect(response).to have_http_status(200) 
    end
  end

  describe "DELETE/genres/:id" do
    it "任意のレコードを削除できる" do
    end
  end


end
