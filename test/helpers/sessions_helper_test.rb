require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:kazukichi)
    remember(@user)
  end

  test "sessions_helper current_user" do
    # assert_equal -> 左が期待する値、右が実際の値
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "sessions_helper current_user2" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end