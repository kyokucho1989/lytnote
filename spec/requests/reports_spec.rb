require 'rails_helper'

# reports     GET    /reports(.:format)           reports#index
#             POST   /reports(.:format)           reports#create
# new_report  GET    /reports/new(.:format)       reports#new
# edit_report GET    /reports/:id/edit(.:format)  reports#edit
# report      GET    /reports/:id(.:format)       reports#show
#             PATCH  /reports/:id(.:format)       reports#update
#             PUT    /reports/:id(.:format)       reports#update
#             DELETE /reports/:id(.:format)       reports#destroy

RSpec.describe "Reports", type: :request do
  before(:context) do
    @user = create(:user)
    @genre = create(:genre, user: @user)
    @report_list = create_list(:report, 3, user: @user)
    @report_list.each do |report|
      FactoryBot.create(:report_item,report_id:report.id,genre_id:@genre.id)
    end
    # after(:build) do |report|
    #   report.report_items << FactoryBot.create(:report_item, content: "織田信長")
    #   report.report_items << FactoryBot.create(:report_items, content: "葛飾北斎")
    # end
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
    subject { get(reports_path( :format => :json )) }
    it "日報一覧が取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res["reports"].size).to eq 3
      expect(res["reports"].first.keys).to eq ["id", "content", "user", "reported_on"]
      expect(response).to have_http_status(200) 
    end
  end

  describe "POST /reports" do
    subject { post(reports_path( :format => :json ), params: params) }
    let(:params) { {report: attributes_for(:report, user_id:@user.id) }}
    it "日報のレコードが作成できる" do
      binding.pry
      expect { subject }.to change { Report.count }.by(1)
      expect(response).to have_http_status(200) 
    end
  end


  describe "GET /show" do
    it "returns http success" do
      sign_in @user
      get "/reports/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      sign_in @user
      get "/reports/new"
      expect(response).to have_http_status(:success)
    end
  end



  describe "GET /edit" do
    it "returns http success" do
      sign_in @user
      get "/reports/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      sign_in @user
      get "/reports/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      sign_in @user
      get "/reports/update"
      expect(response).to have_http_status(:success)
    end
  end
end
