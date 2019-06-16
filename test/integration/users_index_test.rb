require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    # 管理者
    @admin_user = users(:kazukichi)
  end

  # indexページを開いてからuserをdeleteするまでのテスト
  test "admin_user index pagination" do
    log_in_as(@admin_user)
    get users_path(@admin_user)
    assert_template 'users/index'
    assert_select 'ul.pagination'
    assert_difference 'User.count', -1 do
      delete user_path(@admin_user)
    end
    assert_not flash.empty?
  end
end
