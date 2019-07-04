require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:kazukichi)
    # userに紐付いた新しいMicropostオブジェクトを返す
    @micropost = @user.microposts.build(content: "aaa")
  end

  # セットアップのこのマイクロポストは有効か？
  test "micropost should be valid" do
    assert @micropost.valid?
  end

  # マイクロポストのuser_idがnilの場合validatesが機能しているかのテスト
  test "micropost user_id should be presence" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "micropost content should be presence" do
    @micropost.content = ""
    assert_not @micropost.valid?
  end
end
