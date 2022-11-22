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
    @review_list = create_list(:review, 1, user: @user)
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
    subject { get(reviews_path(:format => :json)) }
    it "一覧が取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res["reviews"].size).to eq 3
      expect(res["reviews"].first.keys).to eq ["id", "content", "user", "reviewed_on"]
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /reviews" do
    subject { post(reviews_path(:format => :json), params: params) }
    let(:params) { { review: attributes_for(:review, user: @user) } }
    it "レビューのレコードが作成できる" do
      params[:review]["plans"] = { @plan.id => @plan.slice(:user_id, :deadline, :status) }
      expect { subject }.to change { Review.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /reviews/:id" do
    subject { get(review_path(review_id, :format => :json)) }
    context "指定した id のレコードが存在する場合" do
      let(:review) { create(:review, user: @user) }
      let(:review_id) { review.id }
      it "値が取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(res["content"]).to eq review.content
      end
    end

    context "指定した id の日報が存在しない場合" do
      let(:review_id) { 0 }
      it "日報が見つからない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "PUT /reviews/:id" do
    subject { put(review_path(review.id, :format => :json), params: params) }
    let(:report_item) { attributes_for(:report_item, genre_id: @genre.id) }
    let(:params) { { review: { reviewed_on: review.reviewed_on, content: Faker::Name.name, created_at: Time.current } } }
    let(:review) { create(:review, user: @user) }

    it "任意のレコードを更新できる" do
      params[:review]["plans"] = { @plan.id => @plan.slice(:user_id, :deadline, :status) }
      expect { subject }.to change { Review.find(review.id).content }.from(review.content).to(params[:review][:content]) &
      not_change { Review.find(review.id).created_at }
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE/review/:id" do
    subject { delete(review_path(review.id)) }
    let!(:review) { create(:review, user: @user) }
    it "任意のレコードを削除できる" do
      expect { subject }.to change { Review.count }.by(-1)
      expect(response).to have_http_status(200)
    end
  end
end
