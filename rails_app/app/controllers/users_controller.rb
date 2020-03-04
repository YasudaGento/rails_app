class UsersController < ApplicationController

  def index ;end

  def get
    info = UserService.get()
    
    render json: {info: info}, status: 200
  end
end
