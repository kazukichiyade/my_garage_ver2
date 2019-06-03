require 'test_helper'

class SessionsLoginTest < ActionDispatch::IntegrationTest
  
  # ログインしてからちゃんとフラッシュメッセージが消えるまで
  test "invalid login" do
    get login_path
    assert_template 'sessions/login'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/login'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

end
