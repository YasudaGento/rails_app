class DemoListsController < ApplicationController

  def index
  end

  def get 
    puts "--------------------------"
    puts params.inspect
    puts "--------------------------"
    render json: {}, status: 200
  end
end
