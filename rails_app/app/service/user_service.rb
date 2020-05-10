class UserService < ApplicationService
  class << self
    def get q
      User.excute_list_sql(q)
    end

    def get_detail user_id
      User.excute_for_detail_sql(user_id)
    end

    def update params
      user = User.find(params[:id])
      user_params = make_update_params(params)
      user.skip_password_validation =  params[:password].nil? ? true : false
      user.update!(user_params)
    end

    private

    def make_update_params params
      param = {
        id: params[:id],
        name: params[:name],
        email: params[:email]
      }

      unless params[:password].nil?
        param[:encrypted_password] = Devise::Encryptor.digest(User, params[:password]) 
        param[:password] = params[:password]
      end

      param
    end
  end
end