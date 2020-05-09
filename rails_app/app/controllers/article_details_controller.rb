class ArticleDetailsController < ApplicationController
  def index
    @article_id = params[:article_id]
  end

  def get
    result = ArticleService.get_detail(params[:article_id])
    article_count = ArticleService.get_article_count(params[:article_id])
    
    render json: {info: result, article_count: article_count}, status: 200
  end
end
