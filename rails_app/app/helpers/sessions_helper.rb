module SessionsHelper
  # ログインチェック
  def logined?
    false == session[:user].blank? && User.where(authentication_token: session[:user][:authentication_token]).exists?
  end

  # ログインユーザー情報取得.
  def get_login_user
    logined? ? session[:user] : {}
  end
end
