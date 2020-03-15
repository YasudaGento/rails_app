class SlacksController < ApplicationController
  OFFSET = -10000

  def notificate
    begin
      if Rails.env.production?
        # サーバ側のエラーログを取得
        rails_error_log = LogFileHandler.get(OFFSET, Rails.env)
        axios_error_log = params[:error_log]
        # 本番環境時のみSlckへ通知を送る
        SlackService.notificate(axios_error_log, rails_error_log)
      end

      render json: { message: "エラーメッセージを発報しました" }, status: :ok
    rescue => e
      render json: { message: ErrorMessageHelper.get_err_msg(e) }, status: 500
    end
  end

end

class LogFileHandler
  class << self
    def get offset, type
      file = open(make_file_path(type))
      # ファイルの一番後ろからoffset分取得
      file.sysseek(offset, IO::SEEK_END)
      file.read
    end

    # デバッグしやすいように全ての環境において、ログファイルを見に行けるように定義
    def make_file_path type
      "./log/#{type}.log"
    end
  end
end