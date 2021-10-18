require 'rails_helper'

RSpec.describe "Reports", type: :request do
  before do
    @user = create(:user)
  end

  describe "GET /index" do
    it "returns http success" do
      sign_in @user
      get reports_path
      expect(response).to have_http_status(:success)
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

  describe "GET /create" do
    it "returns http success" do
      sign_in @user
      get "/reports/create"
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
