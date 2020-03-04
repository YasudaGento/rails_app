class UserService < ApplicationService
  class << self
    def get
      User.excute_list_sql()
    end
  end
end