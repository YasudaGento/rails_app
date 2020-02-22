require 'test_helper'

class DemoListsControllerTest < ActionDispatch::IntegrationTest
  test "get list" do
    100.times do |i|
      DemoList.create!(name: "yasuda#{i}")
    end

    get demo_lists_get_path, params: { offset:0 , limit: 0 }
    res = JSON.parse(@response.body)
    
    assert_equal(102, (res["info"].length))
  end
end
