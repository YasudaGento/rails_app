require 'test_helper'

class UserDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get user detail info" do
    get user_details_get_path, params: { user_id: User.first.id }
    res = JSON.parse(@response.body)
   
    # 値を確認
    assert_equal(1, res["count"])
    user = User.first
    article = Article.find_by(user_id: user.id)
    assert_equal(user.id, res["info"][0]["user_id"])
    assert_equal(user.name, res["info"][0]["user_name"])
    assert_equal(user.email, res["info"][0]["email"])
    assert_equal(article.id, res["info"][0]["article_id"])
    assert_equal(article.title, res["info"][0]["title"])
    assert_equal(article.created_at, res["info"][0]["article_created_at"])
  end
end
