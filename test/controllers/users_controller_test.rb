require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    #管理者
    @admin_user = users(:kazukichi)
    #一般
    @other_user = users(:ayachan)
  end

  # users#signupにアクセスできるかのテスト
  test "should get signup" do
    get signup_path
    assert_response :success
  end

  # users#showにアクセスできるかのテスト
  test "should get show" do
    log_in_as(@other_user)
    get user_path(@other_user)
    assert_response :success
  end

  # users#editにログインした一般ユーザーでアクセスできるかのテスト
  test "should get edit" do
    log_in_as(@other_user)
    get edit_user_path(@other_user)
    assert_response :success
  end

  # users#indexにadminユーザーでアクセスできるかのテスト
  test "should get index" do
    log_in_as(@admin_user)
    get users_path(@admin_user)
    assert_response :success
  end

  # users#indexに一般ユーザーでアクセスするとリダイレクトするかのテスト
  test "should get not index" do
    log_in_as(@other_user)
    get users_path(@other_user)
    assert_redirected_to root_url
  end
end
