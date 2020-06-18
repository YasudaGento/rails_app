require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(name: "テスト 太郎", email: "test_sample@mail.com", encrypted_password: "123456789Az")
  end 

  # 概要: 名前が記入されていない時のバリデーションテスト
  test 'should validate when name is nil' do
    @user.skip_password_validation = true
    @user[:name] = nil
    assert(!@user.valid?)
  end

  # 概要: メールが記入されていない時のバリデーションテスト
  test 'should validate when email is nil' do
    @user.skip_password_validation = true
    @user[:email] = nil
    assert(!@user.valid?)
  end

  # 概要: メールがすでに登録されているのバリデーションテスト
  test 'should validate when email already exsists' do
    @user.skip_password_validation = true
    # 一番最初のユーザーのメールと同じ
    @user[:email] = User.first.email
    assert(!@user.valid?)
  end
end
