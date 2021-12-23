require 'rails_helper'

# plans       GET     /plans(.:format)           plans#index
#             POST    /plans(.:format)           plans#create
# new_plan    GET     /plans/new(.:format)       plans#new
# edit_plan   GET     /plans/:id/edit(.:format)  plans#edit
# plan        PATCH   /plans/:id(.:format)       plans#update
#             PUT     /plans/:id(.:format)       plans#update
#             DELETE  /plans/:id(.:format)       plans#destroy

RSpec.describe "Plans", type: :request do
  before(:context) do
    @user = create(:user)
    @genre = create(:genre, user: @user)
    create_list(:plan, 3, user: @user, genre: @genre)
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
    subject { get(plans_path( :format => :json )) }
    it "目標一覧が取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res["plans"].size).to eq 3
      expect(res["plans"].first.keys).to eq ["id", "name", "genre", "deadline", "status"]
      expect(response).to have_http_status(200) 
    end
  end
end
