require "application_system_test_case"

# ユーザー新規登録に関するシステムテスト
class User::CreateTest < ApplicationSystemTestCase
  test "should create user" do
    user = User.first
    TestSessionsHelper.set_login_user({id: user.id, name: user.name })
    ApplicationController.prepend TestSessionsHelper
    # ユーザー件数の事前確認
    assert_equal 50, User.count

    visit "/sessions"

    # 新規登録ボタンを押下
    page.first("#create-btn", wait: 10).click()

    page.find("#user_name", wait: 10).set("新規登録太郎")
    page.find("#create-email", wait: 10).set("create_user_mail@test.com")
    page.find("#create-password", wait: 10).set("Test123456")
    page.find("#confirm_password", wait: 10).set("Test123456")

    page.first("#submit-btn", wait: 10).click()

    # 新規登録成功メッセージの確認
    assert(page.has_text?('ユーザー情報を登録しました。'))

    # 値の確認
    assert_equal("新規登録太郎", User.last.name)
    assert_equal("create_user_mail@test.com", User.last.email)
    # ユーザー件数の確認(一件増えている)
    assert_equal(51, User.count)
  end

  # パスワードが一致していない時のテスト
  test "should validate when password and password confirm are not same" do
    user = User.first
    TestSessionsHelper.set_login_user({id: user.id, name: user.name })
    ApplicationController.prepend TestSessionsHelper
    # ユーザー件数の事前確認
    assert_equal 50, User.count

    visit "/sessions"

    # 新規登録ボタンを押下
    page.first("#create-btn", wait: 10).click()

    page.find("#user_name", wait: 10).set("新規登録太郎")
    page.find("#create-email", wait: 10).set("create_user_mail@test.com")
    page.find("#create-password", wait: 10).set("Test123456")
    # 違うパスワードを入力
    page.find("#confirm_password", wait: 10).set("123456Test")

    page.first("#submit-btn", wait: 10).click()

    # 新規登録成功メッセージの確認
    assert(page.has_text?('パスワードが一致していません'))

    # ユーザーが増えていないことを確認
    assert_equal(50, User.count)
  end
end