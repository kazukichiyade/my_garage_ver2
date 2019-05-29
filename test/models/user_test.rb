require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@examle.com")
  end

  # セットアップのこのユーザーは有効か？
  test "should be valid?" do
    assert @user.valid?
  end

  # name属性に存在性はあるか？
  test "name should be presence" do
    @user.name = ""
    assert_not @user.valid?
  end

  # emailの存在性はあるか？
  test "email should be presence" do
    @user.email = ""
    assert_not @user.valid?
  end
end
