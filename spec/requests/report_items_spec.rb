require 'rails_helper'

RSpec.describe "ReportItems", type: :request do
  describe "GET /destroy" do
    it "returns http success" do
      get "/report_items/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
