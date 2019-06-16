require 'test_helper'

class HomePagesControllerTest < ActionDispatch::IntegrationTest

  # homeにアクセスできるかのテスト
  test "should get home" do
    get root_path
    assert_response :success
  end

end