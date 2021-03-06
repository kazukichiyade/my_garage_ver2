require 'test_helper'

class SessionsLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:kazukichi)
  end

  # ログイン失敗してからちゃんとフラッシュメッセージが消えるまで
  test "invalid login" do
    get login_path
    assert_template 'sessions/login'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/login'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  # ログインしてからviewなど確認ログアウトまで
  test "valid login" do
    get login_path
    assert_template 'sessions/login'
    post login_path, params: { session: { email: @user.email,
                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", signup_path, count: 0
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレート(バグ対策)
    delete logout_path
    follow_redirect!
    assert_template '/'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", signup_path, count: 2
    assert_select "a[href=?]", login_path, count: 1
  end

  # テストユーザーとしてログインしてremember_meがあるかのテスト(単体テスト)
  test "login remember-me" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token'] #テスト内ではcookiesメソッドにシンボルは使えない
  end

  # テストユーザーとしてログインしてログアウトするまでのremember_meがあるかのテスト(統合テスト)
  test "login without remember-me" do
    # クッキーを保存してログイン
    log_in_as(@user, remember_me: '1')
    delete logout_path
    # クッキーを削除してログアウト
    log_in_as(@user, remember_me: '0')
  end
end
