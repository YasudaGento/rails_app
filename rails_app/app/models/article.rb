class Article < ApplicationRecord
  class << self
    def table_name
      return "rails_app_production.articles" if Rails.env == "production"
      return "rails_app_test.articles" if Rails.env == "test"
      return "rails_app_development.articles"
    end

    def excute_list_sql q
      self.joins("LEFT OUTER JOIN #{User.sql_t} AS user_t ON user_t.id = #{self.sql_t}.user_id")
          .select("#{self.sql_t}.title",
                  "#{self.sql_t}.created_at",
                  "user_t.name AS user_name")
          .order(Arel.sql("#{self.sql_t}.created_at DESC"))
          .ransack(q)
          .result
    end
  end

  belongs_to :user
end
