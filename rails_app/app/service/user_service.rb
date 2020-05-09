class UserService < ApplicationService
  class << self
    def get q
      User.excute_list_sql(q)
    end

    def get_detail user_id
      User.excute_for_detail_sql(user_id)
    end
  end
end