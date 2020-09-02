class ArticleService < ApplicationService
  class << self
    def get q
      Article.excute_list_sql(q)
    end

    def get_detail article_id
      Article.excute_for_detail_sql(article_id)
    end

    def update params
      article = Article.find(params[:id])
      article.update!(params)

      article
    end

    def create params
      article = Article.new(params)
      article.save!(params)
    end

    def get_article_count user_id
      Article.where("user_id = #{user_id}").count
    end
  end
end