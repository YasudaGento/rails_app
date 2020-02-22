require "application_system_test_case"

# 大学の編集に関するシステムテスト
class DemoListTest < ApplicationSystemTestCase
  test "demo test" do
    DemoList.destroy_all
    DemoList.create!(name: "yasuda")

    visit "/demo_lists"

    assert page.has_text?('yasuda')
  end
end