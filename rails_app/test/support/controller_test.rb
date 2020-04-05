class ActionDispatch::IntegrationTest
  module TestLoginStatusHelper def is_logined?() true end end

  def setup
    ApplicationController.send :prepend, TestLoginStatusHelper
  end
end