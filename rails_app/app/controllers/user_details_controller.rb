class UserDetailsController < ApplicationController
  def index
    @user_id = params[:user_id]
  end

  def get
    result = UserService.get_detail(params[:user_id])
    article_count = ArticleService.get_article_count(params[:user_id])
    # ログインユーザーIDの取得
    login_user_id = get_login_user[:id]
    
    render json: {info: result, login_user_id: login_user_id, article_count: article_count}, status: 200
  end
end