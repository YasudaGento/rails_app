class SlackService < ApplicationService
  class << self
    def notificate axios_error_log, rails_error_log
      url = 'https://hooks.slack.com/services/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'
      slack = Slack::Notifier.new(url)

      slack.post(
        text: '*バグを探知*',
        attachments: [color: "#ff0000",
        text: axios_error_log]
      )

      slack.post(
        text: '*エラー発生時のサーバ側のログ*',
        attachments: [color: "#ff0000",
        text: rails_error_log]
      )
    end
  end
end