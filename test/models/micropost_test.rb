require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:kazukichi)
    # userに紐付いた新しいMicropostオブジェクトを返す
    @micropost = @user.microposts.build(content: "aaa")
  end

  test "micropost should be valid" do
    assert @micropost.valid?
  end
  
  test "micropost should be presence" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
end
