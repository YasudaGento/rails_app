class ArticlesController < ApplicationController
  def index ;end

  def get
    result = ArticleService.get(params[:q])
    
    render json: {info: result, count: result.size}, status: 200
  end

  def update
    begin
      result = ArticleService.update(permit_params(params[:article]))
      render json: { changed: result }, status: 200
    rescue ActiveRecord::RecordInvalid => e
      render json: { message: ErrorMessageHelper.get_err_msg(e) }, status: 422
    rescue => e
      render json: { message: ErrorMessageHelper.get_err_msg(e) }, status: 500
    end
  end

  def create
    begin
      result = ArticleService.create(permit_params(params[:article]))
      render json: { }, status: 200
    rescue ActiveRecord::RecordInvalid => e
      render json: { message: ErrorMessageHelper.get_err_msg(e) }, status: 422
    rescue => e
      render json: { message: ErrorMessageHelper.get_err_msg(e) }, status: 500
    end
  end

  private

  def permit_params params
    params.permit( :id, :title, :content, :user_id)
  end
end
