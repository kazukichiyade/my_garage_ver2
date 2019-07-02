require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    # actionMailer::BaseはapplicationMailerのsuperクラス
    # グローバルな変数なので毎回クリアする
    ActionMailer::Base.deliveries.clear
    @user = users(:kazukichi)
  end

  # パスワード再設定の統合テスト
  # new_password_resetのnew.html.erbのviewテスト
  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'

    # password_resets_controller createアクションテスト
    # メールアドレスが無効
    post password_resets_path, params: { password_reset: { email: "" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # メールアドレスが有効
    post password_resets_path, params: { password_reset: { email: @user.email } }
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to @user

    # パスワード再設定フォームのテスト
    # インスタンス変数に代入されたオブジェクトを取得(@user)こちらをuserに代入
    user = assigns(:user)

    # 無効なユーザーのテスト(proper_user)
    # edit_password_resetのedit.html.erbのviewが表示までのテスト
    # user.toggle!はactivatedを反転させる(activatedではない状態になる)
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    # 元に戻す
    user.toggle!(:activated)
    # トークンが無効(reset_tokenが無し)、メールアドレスが有効
    get edit_password_reset_path('no_token', email: user.email)
    assert_redirected_to root_url
    # トークンが有効(reset_token)、メールアドレスが無効
    get edit_password_reset_path(user.reset_token, email: "" )
    assert_redirected_to root_url
    # トークンもメールアドレスも有効
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    # 無効なパスワードとパスワード確認
    # password_resets_controller updateアクションテスト
    patch password_reset_path(user.reset_token),
        params: { email: user.email,
            user: { password: "bbbbbb",
                    password_confirmation: "bbbbbb" } }
    assert_not flash.empty?
    # パスワードもパスワード確認も空
    patch password_reset_path(user.reset_token),
        params: { email: user.email,
            user: { password: "",
                    password_confirmation: "" } }
    assert_not flash.empty?
    # パスワードもパスワード確認も有効
    patch password_reset_path(user.reset_token),
        params: { email: user.email,
            user: { password: "aaaaaa",
                    password_confirmation: "aaaaaa"} }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end
end
