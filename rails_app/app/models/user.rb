class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  class << self
    def table_name
      return "rails_app_db.users" if Rails.env == "production"
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
                  "#{self.sql_t}.email",
                  "article_t.id AS article_id",
                  "article_t.title",
                  "article_t.created_at AS article_created_at")
          .where("#{User.sql_t}.id = #{user_id}")
          .limit(10)
          .order(Arel.sql("article_t.created_at DESC"))
    end
  end

  has_many :articles

  validates :name, presence: true, length: {maximum: 20}, null: false
  validates :email, uniqueness: true, presence: true, null: false
  validate :password_validate, unless: :skip_password_validation
  PASSWORD_FORMAT = /\A
    (?=.*\d)      # 数字
    (?=.*[a-z])   # 英小文字
    (?=.*[A-Z])   # 英大文字
  /x

  def password_validate
    self.errors[:password] << "を入力してください" if password.blank?
    self.errors[:password] << "は、半角大文字小文字英数字を含めた文字で入力してください" if !password.match(PASSWORD_FORMAT)
    password.match(PASSWORD_FORMAT) && !password.blank?
  end

  attr_accessor :skip_password_validation
end
