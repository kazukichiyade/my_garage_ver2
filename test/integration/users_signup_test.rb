require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  # 機能テスト(コントローラーの動作やビューの呼び出しチェック)

  # 無効なユーザー登録に対するテスト
  test "invalid signup" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                          email: "user@invalid",
                                          password: "foo",
                                          password_confirmation: "bar" } }
    end
    assert_template 'users/signup'
  end

  # 有効なユーザー登録に対するテスト
  test "valid signup" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "Example User",
                                        email: "user@example.com",
                                        password: "password",
                                        password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
