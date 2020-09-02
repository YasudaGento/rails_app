require 'test_helper'

class ArticleDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get article detail info" do
    get article_details_get_path, params: { article_id: Article.first.id }
    res = JSON.parse(@response.body)
   
    assert_response(200)
    # 値を確認
    assert_equal(1, res["article_count"])
    article = Article.first
    assert_equal(article.user_id, res["info"]["user_id"])
    assert_equal(User.find(article.user_id).name, res["info"]["user_name"])
    assert_equal(article.id, res["info"]["article_id"])
    assert_equal(article.title, res["info"]["title"])
    assert_equal(article.content, res["info"]["content"])
    assert_equal(article.created_at, res["info"]["created_at"])
  end
end
