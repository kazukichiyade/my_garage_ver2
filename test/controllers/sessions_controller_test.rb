require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  # sessions#loginにアクセスできるかのテスト
  test "should get login" do
    get login_path
    assert_response :success
  end

end
