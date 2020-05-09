class UsersController < ApplicationController

  def index ;end

  def get
    result = UserService.get(params[:q])
    info = result.drop(params[:offset].to_i).take(params[:limit].to_i)
    
    render json: {info: info, count: result.size}, status: 200
  end

  def update
    begin
      UserService.update(permit_params(params[:user]))
      render json: { }, status: 200
    rescue ActiveRecord::RecordInvalid => e
      render json: { message: ErrorMessageHelper.get_err_msg(e) }, status: 422
    rescue => e
      render json: { message: ErrorMessageHelper.get_err_msg(e) }, status: 500
    end
  end

  private

  def permit_params params
    params.permit( :id, :name, :password, :email)
  end
end
