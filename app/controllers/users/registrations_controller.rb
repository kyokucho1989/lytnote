class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: %i[update destroy]
  def create
    # アカウント登録のイベントを追加
    super do
      Genre.create!(name: "勉強", user_id: @user.id)
      Genre.create!(name: "運動", user_id: @user.id)
    end
  end

  # DELETE /resource
  def destroy
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource) { redirect_to after_sign_out_path_for(resource_name) }
  end

  def ensure_normal_user
    if resource.email == "guest@example.com"
      redirect_to root_path, alert: "ゲストユーザーは削除できません。"
    end
  end
end