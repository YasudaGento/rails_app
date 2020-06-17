require "application_system_test_case"

# 記事作成に関するシステムテスト
class Article::CreateTest < ApplicationSystemTestCase
  test "should create article" do
    user = User.first
    TestSessionsHelper.set_login_user({id: user.id, name: user.name })
    ApplicationController.prepend TestSessionsHelper
    Article.where(user_id: user.id).delete_all
    visit "/user_details?user_id=#{user.id}"

    # 作成ボタンを押下
    page.first("#create-btn", wait: 10).click()

    page.find("#title", wait: 10).set("新しい記事タイトル")
    page.find("#content", wait: 10).set("新しい記事内容")

    page.first("#submit-btn", wait: 10).click()

    # 編集成功メッセージの確認
    assert(page.has_text?('投稿完了'))
    # 表示の確認
    assert(page.has_text?('新しい記事タイトル'))

    # 値の確認
    assert_equal("新しい記事タイトル", Article.find_by(user_id: user.id).title)
    assert_equal("新しい記事内容", Article.find_by(user_id: user.id).content)
  end

  test "should validate to create article" do
    user = User.first
    TestSessionsHelper.set_login_user({id: user.id, name: user.name })
    ApplicationController.prepend TestSessionsHelper
    Article.where(user_id: user.id).delete_all

    # 値の確認
    assert_equal(0 , Article.where(user_id: user.id).length)

    visit "/user_details?user_id=#{user.id}"

    # 作成ボタンを押下
    page.first("#create-btn", wait: 10).click()
    # 何も入力せずに決定ボタンをおす
    page.first("#submit-btn", wait: 10).click()

    # エラーメッセージの確認
    assert(page.has_text?('タイトルを入力してください'))
    assert(page.has_text?('内容を入力してください'))

    # 値が変更されていないことを確認
    assert_equal(0 , Article.where(user_id: user.id).length)
  end
end