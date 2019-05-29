require 'test_helper'

class HomePagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "My Garage"
  end

  # homeにアクセスできるかのテスト
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

end