import { createLocalVue, shallowmount } from '@vue/test-utils'
import List from "@/components/article/detail_list";
import ElementUI from 'element-ui';
import flushPromise from 'flush-promises'
const localVue = createLocalVue();
localVue.use(ElementUI);

/*
* 記事詳細の表示テスト
*/
describe("test about article detail list", () => {
  const props = {
    localVue,
    stubs: { transition: false },
    propsData: {
      detail_info: {
        article_id: 1,
        title: "test_title",
        content: "test_content",
        article_count: 10,
        user_name: "テスト太郎",
        updated_at: "2020-02-01T12:00:00.000",
        created_at: "2020-01-01T12:00:00.000"
      }
    }
  };

  /**
   * 概要: 表示項目に関するテスト
   * 期待値： Propsで渡された値が正しく表示されている
   */
  it("check about prop data", async () => {
    let wrapper = shallowmount(List, props);
    // 1回目のマウントはflushPromiseを走らせる
    expect(wrapper.find(".el-table__body").text()).toContain("テスト太郎")
    expect(wrapper.find(".el-table__body").text()).toContain("test_title")
    expect(wrapper.find(".el-table__body").text()).toContain("2020-01-01T12:00:00.000")
  });
  
})