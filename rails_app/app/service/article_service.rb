class ArticleService < ApplicationService
  class << self
    def get q
      Article.excute_list_sql(q)
    end

    def get_detail article_id
      Article.excute_for_detail_sql(article_id)
    end
  end
end