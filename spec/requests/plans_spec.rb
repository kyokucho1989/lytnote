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
    create_list(:plan, 3, user: @user, genre_id: @genre.id)
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

  describe "POST /plans" do
    subject { post(plans_path( :format => :json ), params: params) }
    let(:params) { {plan: attributes_for(:plan, genre_id:@genre.id) }}
    it "目標のレコードが作成できる" do
      expect { subject }.to change { Plan.count }.by(1)
      expect(response).to have_http_status(200) 
    end
  end

  describe "PUT /plans/:id" do
    subject { put(plan_path(plan.id, :format => :json ), params: params) }
    let(:params) { { plan: { name: Faker::Name.name, created_at: Time.current } } }
    let(:plan) { create(:plan, user: @user, genre_id: @genre.id) }
    it "任意のレコードを更新できる" do
      expect { subject }.to change { Plan.find(plan.id).name }.from(plan.name).to(params[:plan][:name]) &
      not_change { Plan.find(plan.id).created_at }
      expect(response).to have_http_status(200) 
    end
  end

  # describe "GET /plans/:id" do
  #   subject { get(plan_path(plan.id, :format => :json ))}
  #   context "指定した id の目標が存在する場合" do
  #     let(:plan) { create(:plan, user: @user, genre_id: @genre.id) }
  #     it "目標の値が取得できる" do
  #       subject
  #       res = JSON.parse(response.body)
  #       expect(response).to have_http_status(200)
  #       binding.pry
  #       expect(res["name"]).to eq plan.name
  #       expect(res["deadline"]).to eq plan.deadline
  #       expect(res["status"]).to eq plan.status
  #     end
  #   end

  #   context "指定した id の目標が存在しない場合" do
  #     it "目標が見つからない" do
  #     end
  #   end
  # end

  describe "PUT /plans/:id" do
    subject { put(plan_path(plan.id, :format => :json ), params: params) }
    let(:params) { { plan: { name: Faker::Name.name, created_at: Time.current } } }
    let(:plan) { create(:plan, user: @user, genre_id: @genre.id) }
    it "任意のレコードを更新できる" do
      # binding.pry
      expect { subject }.to change { Plan.find(plan.id).name }.from(plan.name).to(params[:plan][:name]) &
      not_change { Plan.find(plan.id).created_at }
      expect(response).to have_http_status(200) 
    end
  end

  describe "DELETE/plans/:id" do
    subject { delete(plan_path(plan.id)) }
    let!(:plan) { create(:plan, user: @user, genre_id: @genre.id) }
    it "任意のレコードを削除できる" do
      expect { subject }.to change { Plan.count }.by(-1)
      expect(response).to have_http_status(200)
    end
  end
end
