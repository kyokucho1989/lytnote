class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: %i[update destroy]
  def create
    # アカウント登録のイベントを追加
    super do
      Genre.create!(name: "勉強", user_id: @user.id)
      Genre.create!(name: "運動", user_id: @user.id)
    end
  end
  def ensure_normal_user
    if resource.email == "guest@example.com"
      redirect_to root_path, alert: "ゲストユーザーは削除できません。"
    end
  end
end