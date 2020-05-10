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
      user.skip_password_validation =  params[:password].nil? ? true : false
      user.update!(params)
    end

  end
end