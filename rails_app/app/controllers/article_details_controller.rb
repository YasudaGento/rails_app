class ArticleDetailsController < ApplicationController
  def index
    @article_id = params[:article_id]
  end

  def get
    result = ArticleService.get_detail(params[:article_id])
    article_count = ArticleService.get_article_count(params[:article_id])
    # ログインユーザーIDの取得
    login_user_id = get_login_user[:id]
    
    render json: {info: result, article_count: article_count, login_user_id: login_user_id}, status: 200
  end
end
