require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    # deliveriesは変数なので、setupメソッドで初期化しなければ、他のテストメールでエラーが発生
    ActionMailer::Base.deliveries.clear
  end

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
  test "valid signup activation" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "Example User",
                                        email: "user@example.com",
                                        password: "password",
                                        password_confirmation: "password" } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    # assignsメソッドを使うと対応するアクション内のインスタンス変数にアクセスできるようになる
    user = assigns(:user)
    assert_not user.activated?
    # 有効化していない状態でログインしてみる
    log_in_as(user)
    assert_not is_logged_in?

    # 有効化トークンが不正な場合
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?

    # トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(user.activation_token, email: "wrong")
    assert_not is_logged_in?

    # 有効化トークンが正しい場合
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
