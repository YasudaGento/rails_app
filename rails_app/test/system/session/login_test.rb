require "application_system_test_case"

# ユーザーに関するシステムテスト
class SessionLoginTest < ApplicationSystemTestCase
  test "should login with correct password and email" do
    user = User.create!(name: "検証太郎", password: "123456789Test", email: "test_test@mail.com") 
    visit "/sessions"

    # emailを入力
    page.find("#email", wait: 10).set(user.email)
    # passwordを入力
    page.find("#password", wait: 10).set(user.password)
    # ログインボタン押下
    page.find("#submit", wait: 10).click()

    assert page.has_text?('ログインしました')
  end

  test "should not login with uncorrect email" do
    user = User.create!(name: "検証太郎", password: "123456789Test", email: "test_test@mail.com") 
    visit "/sessions"

    # emailを入力
    page.find("#email", wait: 10).set("test2@mail.com")
    # passwordを入力
    page.find("#password", wait: 10).set(user.password)
    # ログインボタン押下
    page.find("#submit", wait: 10).click()

    assert page.has_text?('メールアドレスが正しくありません')
  end

  test "should not login with uncorrect password" do
    user = User.create!(name: "検証太郎", password: "123456789Test", email: "test_test@mail.com") 
    visit "/sessions"

    # emailを入力
    page.find("#email", wait: 10).set(user.email)
    # passwordを入力
    page.find("#password", wait: 10).set("1234")
    # ログインボタン押下
    page.find("#submit", wait: 10).click()

    assert page.has_text?('パスワードが正しくありません')
  end
end