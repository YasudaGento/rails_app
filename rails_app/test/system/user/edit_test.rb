require "application_system_test_case"

# ユーザー編集に関するシステムテスト
class User::EditTest < ApplicationSystemTestCase
  test "should edit user" do
    user = User.first
    TestSessionsHelper.set_login_user({id: user.id, name: user.name })
    ApplicationController.prepend TestSessionsHelper

    visit "/user_details?user_id=#{user.id}"

    # 編集ボタンを押下
    page.first("#edit-btn", wait: 10).click()

    page.find("#user_name", wait: 10).set("編集太郎")
    page.find("#email", wait: 10).set("edit_user_mail@test.com")
    page.find("#password", wait: 10).set("Test123456")
    page.find("#confirm_password", wait: 10).set("Test123456")

    page.first("#submit-btn", wait: 10).click()

    # 編集成功メッセージの確認
    assert page.has_text?('編集完了')

    # 表示の確認
    assert page.has_text?('編集太郎')

    # 値の確認
    assert "編集太郎", User.first.name
    assert "edit_user_mail@test.com", User.first.email
    assert "Test123456", User.first.password
  end

  test "should validate to update user" do
    user = User.first
    TestSessionsHelper.set_login_user({id: user.id, name: user.name })
    ApplicationController.prepend TestSessionsHelper

    visit "/user_details?user_id=#{user.id}"
    user = User.first

    # 編集ボタンを押下
    page.first("#edit-btn", wait: 10).click()

    page.find("#user_name", wait: 10).set(nil)

    page.first("#submit-btn", wait: 10).click()

    # エラーメッセージの確認
    assert page.has_text?('ユーザー名を入力してください')

    # 値が変更されていないことを確認
    assert user.name, User.first.name
  end
end