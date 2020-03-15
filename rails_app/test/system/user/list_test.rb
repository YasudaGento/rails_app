require "application_system_test_case"

# ユーザーに関するシステムテスト
class UserTest < ApplicationSystemTestCase
  test "should get user page" do
    visit "/users"

    assert page.has_text?('ユーザー一覧')
  end
end