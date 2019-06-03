require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  # users#signupにアクセスできるかのテスト
  test "should get signup" do
    get signup_path
    assert_response :success
  end

end
