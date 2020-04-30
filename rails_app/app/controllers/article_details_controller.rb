class ArticleDetailsController < ApplicationController
  def index
    @article_id = params[:article_id]
  end

  def get
    result = ArticleService.get_detail(params[:article_id])
    
    render json: {info: result}, status: 200
  end
end
