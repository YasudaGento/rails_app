ARRAY= /^\[.*\]*$/
class ErrorMessageHelper
  class << self
    def get_err_msg e
      e_msg = self.get(e.message)
      self.print(e_msg)

      e_msg
    end

    def get message
      return array(message) if message =~ ARRAY
      return mdoel_validation(message) if message.include?("バリデーションに失敗しました: ")
      return other(message)
    end

    def print messages
      print_console(messages) unless Rails.env.test? # test実行時、不要なログは出したくない
      print_log(messages) if Rails.env.production?
    end

    def print_console messages
      puts "[ERROR:]"
      puts "-" * 50
      messages.each do |message|
        puts message
      end
      puts "-" * 50
    end

    def print_log messages
      logger = Rails.logger
      logger.error("[ERROR:]")
      logger.error("-" * 50)
      messages.each do |message|
        logger.error(message)
      end
      logger.error("-" * 50)
    end

    def mdoel_validation message
      message.sub("バリデーションに失敗しました: ", '').split(", ")
    end

    def array message
      array_and_double_quote = "[]\""
      message.delete(array_and_double_quote).split(", ")
    end

    def other message
      return message if message.kind_of?(Array)
      return [message]
    end
  end
end