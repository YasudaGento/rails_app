class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_request_filter
  before_action :is_logined?

  def is_logined?
    if false == logined?
      redirect_to sessions_path, alert: "ログインしてからアクセスしてください"
    end
  end

  def set_request_filter
    Thread.current[:request] = request
  end

end