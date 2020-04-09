require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should login with correct user mail and password" do
    # 新しいユーザーを作成
    user = User.create!(name: "検証太郎", password: "123456789Test", email: "test_test@mail.com") 
    post sessions_signin_path, params: { email: user.email, password: user.password }
  
    # レスポンスがredirectになっていてalertが出ていない
    assert_response :redirect
    assert_nil flash['alert']
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
end
