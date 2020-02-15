class DemoListsController < ApplicationController

  def index
  end

  def get 
    info = DemoList.all()
    
    render json: {info: info}, status: 200
  end
end
