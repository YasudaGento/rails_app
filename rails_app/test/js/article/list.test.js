import { createLocalVue, mount } from '@vue/test-utils'
import List from "@/components/article/list";
import ElementUI from 'element-ui';
import flushPromise from 'flush-promises'
const localVue = createLocalVue();
localVue.use(ElementUI);

/*
* 記事一覧の表示テスト
*/
describe("test about article list", () => {
  const props = {
    localVue,
    stubs: { transition: false },
    propsData: {
      info: [{
        user_name: "テスト太郎",
        title: "test_title",
        created_at: "2020-01-01T12:00:00.000"
      }]
    }
  };

  /**
   * 概要: 表示項目に関するテスト
   * 期待値： Propsで渡された値が正しく表示されている
   */
  it("check about prop data", async () => {
    let wrapper = mount(List, props);
    // 1回目のマウントはflushPromiseを走らせる
    await flushPromise()
    expect(wrapper.find(".el-table__body").text()).toContain("テスト太郎")
    expect(wrapper.find(".el-table__body").text()).toContain("test_title")
    expect(wrapper.find(".el-table__body").text()).toContain("20/01/01 12:00")
  });
  
})