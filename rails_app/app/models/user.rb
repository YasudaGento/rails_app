class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  class << self
    def table_name
      return "rails_app_production.users" if Rails.env == "production"
      return "rails_app_test.users" if Rails.env == "test"
      return "rails_app_development.users"
    end

    def excute_list_sql q
      self.select("#{self.sql_t}.id as user_id",
                  "#{self.sql_t}.name as user_name",
                  "#{self.sql_t}.created_at")
          .order(Arel.sql("#{self.sql_t}.created_at DESC"))
          .ransack(q)
          .result()
    end

    def excute_for_detail_sql user_id
      self.joins("LEFT OUTER JOIN #{Article.sql_t} AS article_t ON article_t.user_id = #{self.sql_t}.id")
          .select("#{self.sql_t}.id AS user_id",
                  "#{self.sql_t}.name AS user_name",
                  "#{self.sql_t}.created_at AS user_created_at",
                  "article_t.id AS article_id",
                  "article_t.title",
                  "article_t.created_at AS article_created_at")
          .where("#{User.sql_t}.id = #{user_id}")
    end
  end

  has_many :articles
end
