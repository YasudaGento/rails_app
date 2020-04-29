require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  setup do
    @article = Article.new(title: "title", content: "content", user_id: 1)
  end 

  # 概要: 全ての要素を入れて登録した時のバリデーションテスト
  test 'test case which has all col' do
    assert @article.valid?
  end

  # 概要: タイトルが記入されていない時のバリデーションテスト
  test 'should validate when title is nil' do
    @article[:title] = nil
    assert !@article.valid?
  end

  # 概要: 内容が記入されていない時のバリデーションテスト
  test 'should validate when content is nil' do
    @article[:content] = nil
    assert !@article.valid?
  end
end