class ArticlesController < ApplicationController
  def index ;end

  def get
    result = ArticleService.get(params[:q])
    
    render json: {info: result, count: result.size}, status: 200
  end
end