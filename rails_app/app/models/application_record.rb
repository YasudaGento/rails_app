class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # メソッド名: sql_t
  # 動作: sqlを発行する際のtable名を取得
  # 引数: なし
  # 戻り値: tableの名前
  def self.sql_t
    arr = self.table_name.split(".")
    "`" + arr[0] + "`" + "." + "`" + arr[1] + "`"
  end
end
