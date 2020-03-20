class ArticleService < ApplicationService
  class << self
    def get 
      Article.excute_list_sql()
    end
  end
end