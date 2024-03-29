class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    # ゲストアカウントでログイン
    sign_in User.guest
    # トップページへリダイレクト
    redirect_to plans_path, notice: "ゲストユーザーとしてログインしました。"
  end
end
