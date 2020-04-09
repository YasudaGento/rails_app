ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"
require 'capybara/rails'
require 'test_sessions_helper'

Dir.glob("./test/support/*.rb") do |f|
  require_dependency Rails.root.join(f)
end

ActiveRecord::Base.logger = nil
# 各テストの実行時間を表示
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new, Minitest::Reporters::JUnitReporter.new]
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end
