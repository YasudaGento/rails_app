class ActionDispatch::IntegrationTest
  module TestLoginStatusHelper def is_logined?() true end end

  def setup
    ApplicationController.prepend TestLoginStatusHelper
  end
end