require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get articles_get_path, params: { q: {} }
    res = JSON.parse(@response.body)
    
    # ユーザー50件の取得
    assert_equal(50, (res["info"].length))
    # 投稿者、タイトル、作成日が正しく取得できている
    assert_equal('テスト太郎49', res["info"][0]['user_name'])
    assert_equal('テストタイトル49', res["info"][0]['title'])
    #　新しい作成日順に取得できている
    date_1 = DateTime.parse('2020-05-03T12:00:00').strftime().split("T")[0]
    assert_equal(date_1, res["info"][0]['created_at'].split("T")[0])
    date_2 = DateTime.parse('2020-03-15T12:00:00').strftime().split("T")[0]
    assert_equal(date_2, res["info"][49]['created_at'].split("T")[0])
  end

  # 検索結果が0件でもステータスが200を返している
  test "should get right status when seraching reslut is zero" do
    # 存在しない名前で検索
    params = {user_name_cont: 'テスト太郎100'}
    get articles_get_path, params: { offset:0 , limit: 0, q: params }
    res = JSON.parse(@response.body)
    
    # ユーザー0件の取得
    assert_equal(200, (@response.status))
    assert_equal(0, (res["info"].length))
  end

  test "should get a record by seraching user name" do
    # テスト太郎48で検索
    params = {user_name_cont: 'テスト太郎48'}
    get articles_get_path, params: { offset:0 , limit: 0, q: params }
    res = JSON.parse(@response.body)
    
    # ユーザー1件の取得
    assert_equal(1, (res["info"].length))
    # テスト太郎48が取得されている
    assert_equal('テスト太郎48', res["info"][0]['user_name'])
  end

  test "should get a record by seraching title" do
    # テストタイトル49で検索
    params = {title_cont: 'テストタイトル49'}
    get articles_get_path, params: { offset:0 , limit: 0, q: params }
    res = JSON.parse(@response.body)
    
    # 1件の取得
    assert_equal(1, (res["info"].length))
    # テストタイトル49が取得されている
    assert_equal('テストタイトル49', res["info"][0]['title'])
  end

  # 作成日（以降）検索、作成日よりも後の日付のもののみ取得
  test "should get a record by seraching more than created date" do
    # 5月1日で検索
    params = {created_at_gteq: '2020-05-01'}
    get articles_get_path, params: { offset:0 , limit: 0, q: params }
    res = JSON.parse(@response.body)
    
    # 3件の取得
    assert_equal(3, (res["info"].length))
    # 5月1日以降のレコードのみ取得している
    date_1 = DateTime.parse('2020-05-03T12:00:00').strftime().split("T")[0]
    date_2 = DateTime.parse('2020-05-02T12:00:00').strftime().split("T")[0]
    date_3 = DateTime.parse('2020-05-01T12:00:00').strftime().split("T")[0]
    assert_equal(date_1, res["info"][0]['created_at'].split("T")[0])
    assert_equal(date_2, res["info"][1]['created_at'].split("T")[0])
    assert_equal(date_3, res["info"][2]['created_at'].split("T")[0])
  end

  # 作成日（以前）検索、作成日よりも前の日付のもののみ取得
  test "should get a record by seraching less than created date" do
    # 3月17日で検索
    params = {created_at_lteq: '2020-03-17'}
    get articles_get_path, params: { offset:0 , limit: 0, q: params }
    res = JSON.parse(@response.body)
    
    # 2件の取得
    assert_equal(2, (res["info"].length))
    # 3月17日以前のレコードのみ取得している
    date_1 = DateTime.parse('2020-03-16T12:00:00').strftime().split("T")[0]
    date_2 = DateTime.parse('2020-03-15T12:00:00').strftime().split("T")[0]
    assert_equal(date_1, res["info"][0]['created_at'].split("T")[0])
    assert_equal(date_2, res["info"][1]['created_at'].split("T")[0])
  end

  # 日付の範囲で検索ができているかのテスト
  test "should search date range" do
    # 3月17日より前で3月16日以降の日付で検索
    params = {created_at_lteq: '2020-03-17'}
    params[:created_at_gteq] = '2020-03-16'
    get articles_get_path, params: { offset:0 , limit: 0, q: params }
    res = JSON.parse(@response.body)
    
    # 1件の取得
    assert_equal(1, (res["info"].length))
    # 3月16日のレコードのみ取得している
    date_1 = DateTime.parse('2020-03-16T12:00:00').strftime().split("T")[0]
    assert_equal(date_1, res["info"][0]['created_at'].split("T")[0])
  end

  #　全ての項目で検索
  test "should get a record by all serching items" do
    # 3月17日より前で3月16日以降の日付で検索
    params = {created_at_lteq: '2020-03-17'}
    params[:created_at_gteq] = '2020-03-16'
    params[:user_name_cont] = 'テスト太郎1'
    params[:title_cont] = 'テストタイトル1'
    get articles_get_path, params: { offset:0 , limit: 0, q: params }
    res = JSON.parse(@response.body)
    
    # 1件の取得
    assert_equal(1, (res["info"].length))
    # 取得データの確認
    assert_equal('テスト太郎1', res["info"][0]['user_name'])
    assert_equal('テストタイトル1', res["info"][0]['title'])
    date_1 = DateTime.parse('2020-03-16T12:00:00').strftime().split("T")[0]
    assert_equal(date_1, res["info"][0]['created_at'].split("T")[0])
  end
end
