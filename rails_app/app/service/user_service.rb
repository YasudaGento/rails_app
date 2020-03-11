class UserService < ApplicationService
  class << self
    def get q
      User.excute_list_sql(q)
    end
  end
end