class Article < ApplicationRecord
  class << self
    def table_name
      return "rails_app_production.articles" if Rails.env == "production"
      return "rails_app_test.articles" if Rails.env == "test"
      return "rails_app_development.articles"
    end
  end
end
