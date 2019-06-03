require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  # users#newにアクセスできるかのテスト
  test "should get new" do
    get signup_path
    assert_response :success
  end

end
