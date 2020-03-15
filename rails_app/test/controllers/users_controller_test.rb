require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get users_get_path, params: { offset:0 , limit: 0, q: {} }
    res = JSON.parse(@response.body)
    
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
    get users_get_path, params: { offset:0 , limit: 0, q: params }
    res = JSON.parse(@response.body)
    
    # ユーザー1件の取得
    assert_equal(1, (res["info"].length))
    # テスト太郎48が取得されている
    assert_equal('テスト太郎48', res["info"][0]['user_name'])
  end

  # 検索結果が0件でもステータスが200を返している
  test "should get right status when seraching reslut is zero" do
    # 存在しない名前で検索
    params = {name_cont: 'テスト太郎100'}
    get users_get_path, params: { offset:0 , limit: 0, q: params }
    res = JSON.parse(@response.body)
    
    # ユーザー0件の取得
    assert_equal(200, (@response.status))
    assert_equal(0, (res["info"].length))
  end
end
