class ArticleService < ApplicationService
  class << self
    def get q
      Article.excute_list_sql(q)
    end
  end
end