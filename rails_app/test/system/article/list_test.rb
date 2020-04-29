require "application_system_test_case"

# 記事一覧に関するシステムテスト
class Article::ListTest < ApplicationSystemTestCase
  test "should get article page" do
    visit "/articles"

    assert page.has_text?('記事一覧')
  end

  test "should work searching function" do
    visit "/articles"

    # タイトルで検索
    page.find("#title", wait: 10).set("タイトル40")

    # 検索ボタンを押下
    page.first("#submit-btn", wait: 10).click()

    # 一件だけ取得している
    assert page.has_text?('(1件)')
    # タイトル40が表示されている
    assert page.has_text?('タイトル40')
  end
end