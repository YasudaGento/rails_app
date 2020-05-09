class UserDetailsController < ApplicationController
  def index
    @user_id = params[:user_id]
  end

  def get
    result = UserService.get_detail(params[:user_id])
    
    render json: {info: result, count: result.length}, status: 200
  end
end