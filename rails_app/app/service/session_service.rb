class SessionService < ApplicationService
  class << self
    def signin params
      user = User.find_for_database_authentication(email: params[:email])
      raise AccountMailInvalidError.new if user.nil?
      if user.valid_password?(params[:password])
        if user.authentication_token.nil?
          # token生成
          user.update_attributes(authentication_token: SecureRandom.hex(20))
        end
        user
      else
        raise AccountPasswordInvalidError.new
      end
    end
  end
end

class AccountMailInvalidError < StandardError; end
class AccountPasswordInvalidError < StandardError; end