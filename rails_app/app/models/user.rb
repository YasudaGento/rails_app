class User < ApplicationRecord
  class << self
    def table_name
      return "rails_app_production.users" if Rails.env == "production"
      return "rails_app_test.users" if Rails.env == "test"
      return "rails_app_development.users"
    end

    def excute_list_sql q
      self.select("#{self.sql_t}.name as user_name",
                  "#{self.sql_t}.created_at")
          .order("#{self.sql_t}.created_at DESC")
          .ransack(q)
          .result()
    end
  end
end
