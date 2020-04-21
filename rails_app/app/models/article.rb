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
                  "#{self.sql_t}.id AS article_id",
                  "user_t.name AS user_name")
          .order(Arel.sql("#{self.sql_t}.created_at DESC"))
          .ransack(q)
          .result
    end

    def excute_for_detail_sql article_id
      self.joins("LEFT OUTER JOIN #{User.sql_t} AS user_t ON user_t.id = #{self.sql_t}.user_id")
          .select("#{self.sql_t}.title",
                  "#{self.sql_t}.created_at",
                  "#{self.sql_t}.updated_at",
                  "#{self.sql_t}.content",
                  "user_t.name AS user_name")
          .find(article_id)
    end
  end

  belongs_to :user
end
