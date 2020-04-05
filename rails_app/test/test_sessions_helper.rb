# テスト用セッションヘルパー
#
# 返したいスタッフ情報をset_login_userで設定し、Controllerへprependする
module TestSessionsHelper
  @@user = { id: 1 }
  def get_login_user
    @@user
  end

  # 返したいユーザー情報を設定する
  def set_login_user user; @@user = user end

  module_function :set_login_user
end