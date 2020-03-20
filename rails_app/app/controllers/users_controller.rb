class UsersController < ApplicationController

  def index ;end

  def get
    result = UserService.get(params[:q])
    info = result.drop(params[:offset].to_i).take(params[:limit].to_i)
    
    render json: {info: info, count: result.size}, status: 200
  end
end
