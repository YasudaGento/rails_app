require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should login with correct user mail and password" do
    # 新しいユーザーを作成
    user = User.create!(name: "検証太郎", password: "123456789Test", email: "test_test@mail.com") 
    post sessions_signin_path, params: { email: user.email, password: user.password }
  
    assert_equal("ログインしました。", flash['notice'])
  end

  test "should not login with uncorrect user password" do
    # 新しいユーザーを作成
    user = User.create!(name: "検証太郎", password: "123456789Test", email: "test_test@mail.com") 
    post sessions_signin_path, params: { email: user.email, password: 'sdfghj' }

    assert_equal("パスワードが正しくありません。", flash['alert'])
  end

  test "should not login with uncorrect user email" do
    # 新しいユーザーを作成
    user = User.create!(name: "検証太郎", password: "123456789Test", email: "test_test@mail.com") 
    post sessions_signin_path, params: { email: 'wrong_mail@mail.com', password: user.password }

    assert_equal("メールアドレスが正しくありません。", flash['alert'])
  end

  test "should logout correctly" do
    # 新しいユーザーを作成
    user = User.create!(name: "検証太郎", password: "123456789Test", email: "test_test@mail.com", authentication_token: SecureRandom.hex(20))
    # 一度ログイン
    post sessions_signin_path, params: { email: user.email, password: user.password }
    assert_equal("ログインしました。", flash['notice'])

    # ログアウト
    delete sessions_signout_path
    assert_equal("ログアウトしました。", flash['notice'])
    # トークンが削除されている
    assert_nil User.find_by(name: "検証太郎").authentication_token
  end
end
