require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  # Homeページのviewのlayoutやlinkが合ってるかのテスト
  test "home layout links" do
    get root_path
    assert_template 'home_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", signup_path, count: 2
    assert_select "a[href=?]", login_path, count: 1
  end

  # signupページのviewのlayoutやlinkが合ってるかのテスト
  test "signup layout links" do
    get signup_path
    assert_template 'users/signup'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", signup_path, count: 1
    assert_select "a[href=?]", login_path, count: 2
  end

  # loginページのviewのlayoutやlinkが合ってるかのテスト
  test "login layout links" do
    get login_path
    assert_template 'sessions/login'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", signup_path, count: 2
    assert_select "a[href=?]", login_path, count: 1
  end
end
