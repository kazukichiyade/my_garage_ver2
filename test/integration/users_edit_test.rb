require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:kazukichi)
    @other_user = users(:ayachan)
  end

  name = "kazukichi"
  email = "kazukichi@example.com"
  a_word = "マツダアテンザ"
  introduction = "こんにちは"

  # プロフィール更新失敗のテスト
  test "users_edit not_complate" do
    # テストユーザーとしてログインする(before_actionで定義されたため)
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                            email: email,
                            password: "",
                            password_confirmation: "",
                            a_word: a_word,
                            introduction: introduction } }
    assert_template 'users/edit'
  end

  # プロフィール更新成功のテスト
  test "users_edit complate" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: name,
                                    email: email,
                                    password: "",
                                    password_confirmation: "",
                                    a_word: a_word,
                                    introduction: introduction } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal a_word, @user.a_word
    assert_equal introduction, @user.introduction
  end

  # ログインしていないユーザーからの保護テスト(edit)
  test "edit not logged_in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # ログインしていないユーザーからの保護テスト(update)
  test "update not logged_in" do
    patch user_path(@user), params: { user: { name: name,
                            email: email,
                            password: "",
                            password_confirmation: "",
                            a_word: a_word,
                            introduction: introduction } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # ログインしているが持ち主と違うユーザーからの保護テスト(edit)
  test "edit logged_in other_user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  # ログインしているが持ち主と違うユーザーからの保護テスト(update)
  test "update logged_in other_user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: name,
                            email: email,
                            password: "",
                            password_confirmation: "",
                            a_word: a_word,
                            introduction: introduction } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
