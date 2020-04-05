class SessionsController < ApplicationController
  include SessionsHelper
  skip_before_action :is_logined?

  def index; end

  def signin
    begin
      permited_params = permit_params(params)
      user = SessionService.signin(permited_params)
      # セッションの保存
      create_session(user)
      redirect_to :articles
    rescue AccountMailInvalidError => e
      redirect_to :sessions, alert: "メールアドレスが正しくありません。"
      return
    rescue AccountPasswordInvalidError => e
      redirect_to :sessions, alert: "パスワードが正しくありません。"
      return
    rescue => e
      redirect_to :sessions, alert: "原因不明のエラーです。"
      return
    end
  end

  def signout
    begin
      SessionService.signout(get_login_user())
      # セッションの削除
      logout()
      redirect_to :sessions
    rescue => e
      redirect_to :sessions, alert: "原因不明のエラーです。"
      return
    end
  end

  private

  def create_session(info)
    session[:user] = {}
    session[:user][:id] = info["id"]
    session[:user][:name] = info["name"]
    session[:user][:email] = info["email"]
    session[:user][:authentication_token] = info["authentication_token"]
  end

  def logout
    session[:user] = nil
  end

  # ログインユーザー情報取得.
  def get_login_user
    logined? ? session[:user] : {}
  end

  def permit_params params
    params.permit(:password, :email, :authenticity_token)
  end
end

class AccountMailInvalidError < StandardError; end
class AccountPasswordInvalidError < StandardError; end