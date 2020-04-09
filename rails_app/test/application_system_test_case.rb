require 'test_helper'
require 'capybara'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase

  # Capybaraの設定
  Capybara.configure do |config|
    config.app = Rack::URLMap.new('/' => Rails.application)
    config.app_host = "http://nginx:19800" # テスト用nginxポート
    config.server_host = "0.0.0.0"
    config.server_port = 19801
    ActionController::Base.asset_host = "http://nginx:19800" # vue.js sassのパス指定
  end

  Capybara.register_driver :selenium_remote do |app|
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 200
    url = "http://chrome:4444/wd/hub"
    opts = { desired_capabilities: :chrome, browser: :remote, url: url }
    Capybara::Selenium::Driver.new(app, opts)
  end

  # 事前処理
  def setup
    # ログインシュミレーション
    ApplicationController.prepend TestLoginStatusHelper

    host! "http://nginx:19800"
  end

  # フルスクリーンで撮影する
  def take_full_page_screenshot(name)
    width  = Capybara.page.execute_script("return Math.max(document.body.scrollWidth, document.body.offsetWidth, document.documentElement.clientWidth, document.documentElement.scrollWidth, document.documentElement.offsetWidth);")
    height = Capybara.page.execute_script("return Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight);")
    window = Capybara.current_session.driver.browser.manage.window
    window.resize_to(width+100, height+100)

    page.save_screenshot(name)
  end

  # driver設定
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: {
      args: %w(headless disable-gpu)
    }
  )
  driven_by :selenium_remote, using: :selemium_headless_chrome, options: { desired_capabilities: capabilities }
end