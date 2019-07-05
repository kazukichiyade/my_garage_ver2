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

  # contentが空だった場合validatesの存在性が機能しているか
  test "micropost content should be presence" do
    @micropost.content = ""
    assert_not @micropost.valid?
  end

  # contentのvalidatesのlengthが機能しているか
  test "micropost content length maximum" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  # 投稿した時一番初めにmicroposts.ymlのoneが一番初めに投稿しているか
  test "micropost first" do
    assert_equal microposts(:one), Micropost.first
  end

  # microposts.ymlのtwoが初めの投稿でなければtrue
  test "micropost not first" do
    assert_not_equal microposts(:two), Micropost.first
  end
end
