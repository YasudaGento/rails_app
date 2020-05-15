require "application_system_test_case"

# 記事編集に関するシステムテスト
class Article::EditTest < ApplicationSystemTestCase
  test "should edit article" do
    user = User.find(Article.first.user_id)
    TestSessionsHelper.set_login_user({id: user.id, name: user.name })
    ApplicationController.prepend TestSessionsHelper
    visit "/article_details?article_id=#{Article.first.id}"

    # 編集ボタンを押下
    page.first("#edit-btn", wait: 10).click()

    page.find("#title", wait: 10).set("編集後タイトル")
    page.find("#content", wait: 10).set("編集後内容")

    page.first("#submit-btn", wait: 10).click()

    # 編集成功メッセージの確認
    assert page.has_text?('編集完了')
    # 表示の確認
    assert page.has_text?('編集後タイトル')
    assert page.has_text?('編集後内容')

    # 値の確認
    assert "編集後タイトル", Article.first.title
    assert "編集後内容", Article.first.content
  end

  test "should validate to update article" do
    user = User.find( Article.first.user_id)
    TestSessionsHelper.set_login_user({id: user.id, name: user.name })
    ApplicationController.prepend TestSessionsHelper
    visit "/article_details?article_id=#{Article.first.id}"
    article = Article.first

    # 編集ボタンを押下
    page.first("#edit-btn", wait: 10).click()

    page.find("#title", wait: 10).set(nil)
    page.find("#content", wait: 10).set(nil)

    page.first("#submit-btn", wait: 10).click()

    # エラーメッセージの確認
    assert page.has_text?('タイトルを入力してください')
    assert page.has_text?('内容を入力してください')

    # 値が変更されていないことを確認
    assert article.title, Article.first.title
    assert article.content, Article.first.content
  end
end