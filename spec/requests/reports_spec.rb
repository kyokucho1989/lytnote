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
    let(:report_item) { attributes_for(:report_item, genre_id:@genre.id)}
    let(:params) { {report: attributes_for(:report)}}
  
    it "日報のレコードが作成できる" do
      params[:report]["report_items_attributes"] = {0 => report_item}
      expect { subject }.to change { Report.count }.by(1)
      expect(response).to have_http_status(200) 
    end
  end

  describe "GET /reports/:id" do
    subject { get(report_path(report_id, :format => :json ))}
    context "指定した id の日報が存在する場合" do
      let(:report) { create(:report, user: @user) }
      let(:report_id) { report.id }
      it "日報の値が取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(res["content"]).to eq report.content
      end
    end

    context "指定した id の日報が存在しない場合" do
      let(:report_id) { 0 }
      it "日報が見つからない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "PUT /reports/:id" do
    subject { put(report_path(report.id, :format => :json ), params: params) }
    let(:report_item) { attributes_for(:report_item, genre_id:@genre.id)}
    let(:params) { { report: { reported_on:report.reported_on, content: Faker::Name.name, created_at: Time.current } } }
    let(:report) { create(:report, user: @user) }
    it "任意のレコードを更新できる" do
      params[:report]["report_items_attributes"] = {0 => report_item}
      expect { subject }.to change { Report.find(report.id).content }.from(report.content).to(params[:report][:content]) &
      not_change { Report.find(report.id).created_at }
      expect(response).to have_http_status(200) 
    end
  end


  describe "GET /destroy" do
    it "returns http success" do
      sign_in @user
      get "/reports/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
