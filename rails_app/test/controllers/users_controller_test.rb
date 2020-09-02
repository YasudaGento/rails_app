require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get users_get_path, params: { offset: 0 , limit: 50, q: {} }
    res = JSON.parse(@response.body)
    
    assert_response(200)
    # ユーザー50件の取得
    assert_equal(50, (res["info"].length))
    # ユーザーの作成された最新順に表示されている
    date_1 = DateTime.parse('2020-03-15T12:00:00').strftime().split("T")[0]
    assert_equal(date_1, res["info"][0]['created_at'].split("T")[0])
    date_2 = DateTime.parse('2020-01-26T12:00:00').strftime().split("T")[0]
    assert_equal(date_2, res["info"][49]['created_at'].split("T")[0])
  end

  test "should get only a searched record" do
    # テスト太郎48で検索
    params = {name_cont: 'テスト太郎48'}
    get users_get_path, params: { offset: 0 , limit: 50, q: params }
    res = JSON.parse(@response.body)
    
    assert_response(200)
    # ユーザー1件の取得
    assert_equal(1, (res["info"].length))
    # テスト太郎48が取得されている
    assert_equal('テスト太郎48', res["info"][0]['user_name'])
  end

  # 検索結果が0件でもステータスが200を返している
  test "should get right status when seraching reslut is zero" do
    # 存在しない名前で検索
    params = {name_cont: 'テスト太郎100'}
    get users_get_path, params: { offset:0 , limit: 50, q: params }
    res = JSON.parse(@response.body)
    
    assert_response(200)
    # ユーザー0件の取得
    assert_equal(0, (res["info"].length))
  end

  # ユーザー情報が正しく編集できることのテスト
  test "should update user info" do
    user = User.first
    # 更新前の値確認
    assert_equal("テスト太郎0", user.name)
    assert_equal("user0@example.com", user.email)

    params = {
      user: {
        id: user.id,
        name: "test太郎",
        email: "changed_test@mail.com",
        password: "123456789Az"
      }
    }
    post users_update_path, params: params, as: :json
    
    # ステータスの確認
    assert_response(200)
    # 値の確認
    assert_equal(params[:user][:name], User.first.name)
    assert_equal(params[:user][:email], User.first.email)
  end

  # ユーザー情報が正しくない時に編集ができない
  test "should not update user info" do
    user = User.first
    # 更新前の値確認
    assert_equal("テスト太郎0", user.name)
    assert_equal("user0@example.com", user.email)

    # 名前をnilで編集
    params = {
      user: {
        id: user.id,
        name: nil,
        email: "changed_test@mail.com",
        password: "123456789Az"
      }
    }
    post users_update_path, params: params, as: :json
    res = JSON.parse(@response.body)
    
    # ステータスの確認
    assert_response(422)
    # 値の確認
    assert_equal("ユーザー名を入力してください", res["message"][0])
  end

  # パスワードが6文字以下の際のテスト
  test "should validate when update password less than 6 letters" do
    user = User.first

    # パスワードが4文字
    params = {
      user: {
        id: user.id,
        name: "test太郎",
        email: "changed_test@mail.com",
        password: "12Ab"
      }
    }
    post users_update_path, params: params, as: :json
    res = JSON.parse(@response.body)
    
    # ステータスの確認
    assert_response(422)
    # 値の確認
    assert_equal("パスワードは6文字以上で入力してください", res["message"][0])
  end

  # パスワードに数字しか含まれていない時のテスト
  test "should validate when update password dosent include number and string" do
    user = User.first

    # パスワードが数字のみ
    params = {
      user: {
        id: user.id,
        name: "test太郎",
        email: "changed_test@mail.com",
        password: "12345677"
      }
    }
    post users_update_path, params: params, as: :json
    res = JSON.parse(@response.body)
    
    # ステータスの確認
    assert_response(422)
    # 値の確認
    assert_equal("パスワードは、半角大文字小文字英数字を含めた文字で入力してください", res["message"][0])
  end

  # パスワードがemptyの時のテスト
  test "should validate when update password is empty" do
    user = User.first

    # パスワードが空文字
    params = {
      user: {
        id: user.id,
        name: "test太郎",
        email: "changed_test@mail.com",
        password: ""
      }
    }
    post users_update_path, params: params, as: :json
    res = JSON.parse(@response.body)
    
    # ステータスの確認
    assert_response(422)
    # 値の確認
    assert_equal("パスワードを入力してください", res["message"][0])
  end

  # ユーザー情報が正しく登録できることのテスト
  test "should create user" do
    # 更新前の値確認(ユーザーが50件登録されている)
    assert_equal(50, User.count)

    params = {
      user: {
        name: "test太郎",
        email: "new_user@mail.com",
        password: "123456789Az"
      }
    }
    post users_create_path, params: params, as: :json
    
    # ステータスの確認
    assert_response(200)
    # 値の確認
    assert_equal(params[:user][:name], User.last.name)
    assert_equal(params[:user][:email], User.last.email)
    # 一件増えて51件になっている
    assert_equal(51, User.count)
  end

  # すでに登録されているユーザーのメールアドレスの場合登録できないこと
  test "should not create user when user's mail address is already added" do
    # 更新前の値確認(ユーザーが50件登録されている)
    assert_equal(50, User.count)

    params = {
      user: {
        name: "test太郎",
        email: User.first.email, #すでにあるメールアドレスで登録
        password: "123456789Az"
      }
    }
    post users_create_path, params: params, as: :json
    res = JSON.parse(@response.body)

    # ステータスの確認
    assert_response(422)
    # 値の確認
    assert_equal("メールアドレスはすでに存在します", res["message"][0])
    # 件数は元のまま
    assert_equal(50, User.count)
  end
end
