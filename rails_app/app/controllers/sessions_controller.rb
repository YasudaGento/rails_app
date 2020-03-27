class SessionsController < ApplicationController
  # include SessionsHelper
  # BASE_URI = "http://auth:3000"
  # skip_before_action :is_logined?

  def index; end

  #サインイン
  def signin
    puts "-----------------------------"
    puts params.inspect
    puts "-----------------------------"
    # # 認証サーバーへ問い合わせ.
    # client = Faraday.new(:url => BASE_URI)
    # res = client.post do |req|
    #   req.url "/api/v1/signin"
    #   req.headers["Content-Type"] = "application/json"
    #   req.body = {email: params[:email], password: params[:password]}.to_json
    # end

    # # レスポンス確認.
    # res = JSON.parse(res.body)
    # if res["result"] == "success"
    #   # トークンをセッションへ保存.
    #   login(res["staff"])

    #   redirect_to :root
    # else
    #   case res["detail"]
    #   when "account or password miss"  then
    #     redirect_to :sessions, alert: "メールアドレスもしくは、パスワードが違います"
    #     return
    #   when "account invalid" then
    #     redirect_to :sessions, alert: "アカウントが無効化されています"
    #     return
    #   end
    # end
  end

  private

  def login(info)
    session[:staff] = {}
    session[:staff][:id] = info["id"]
    session[:staff][:username] = info["username"]
    session[:staff][:email] = info["email"]
    session[:staff][:authentication_token] = info["authentication_token"]
  end

  def logout
    session[:staff] = nil
  end

  # ログインチェック
  def logined?
    false == session[:staff].blank? && Staff.where(authentication_token: session[:staff][:authentication_token]).exists?
  end

  # ログインユーザー情報取得.
  def get_login_user
    logined? ? session[:staff] : {}
  end
end