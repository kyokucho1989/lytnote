require 'rails_helper'

# re_select_plan_review   GET    /reviews/:id/re_select_plan(.:format)  reviews#re_select_plan
# select_plan_reviews     GET    /reviews/select_plan(.:format)         reviews#select_plan
# change_state_reviews    GET    /reviews/change_state(.:format)        reviews#change_state
#             reviews     GET    /reviews(.:format)                     reviews#index
#                         POST   /reviews(.:format)                     reviews#create
#          new_review     GET    /reviews/new(.:format)                 reviews#new
#         edit_review     GET    /reviews/:id/edit(.:format)            reviews#edit
#              review     GET    /reviews/:id(.:format)                 reviews#show
#                         PATCH  /reviews/:id(.:format)                 reviews#update
#                         PUT    /reviews/:id(.:format)                 reviews#update
#                         DELETE /reviews/:id(.:format)                 reviews#destroy

RSpec.describe "Reviews", type: :request do

  before(:context) do
    @user = create(:user)
    @genre = create(:genre, user: @user)
    @plan = create(:plan, user: @user, genre: @genre)
    @review_list = create_list(:review, 3, user: @user)
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

  describe "GET /index" do
    subject { get(reviews_path( :format => :json )) }
    it "一覧が取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res["reviews"].size).to eq 3
      expect(res["reviews"].first.keys).to eq ["id", "content", "user", "reviewed_on"]
      expect(response).to have_http_status(200) 
    end
    
  end

  describe "POST /reviews" do
    subject { post(reviews_path( :format => :json ), params: params) }
    let(:params) { {review: attributes_for(:review, user: @user)}}
    it "レビューのレコードが作成できる" do
      params[:review]["plans"] = {@plan.id =>  @plan.slice(:user_id,:deadline,:status)}
      expect { subject }.to change { Review.count }.by(1)
      expect(response).to have_http_status(200) 
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/reviews/index"
      expect(response).to have_http_status(:success)
    end
  end



  describe "GET /show" do
    it "returns http success" do
      get "/reviews/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/reviews/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/reviews/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/reviews/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/reviews/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/reviews/update"
      expect(response).to have_http_status(:success)
    end
  end
end
