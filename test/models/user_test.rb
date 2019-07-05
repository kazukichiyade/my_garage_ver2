require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # 単体テスト(モデルやビューヘルパー単体の動作チェック)

  def setup
    @user = User.new(name: "Example User", email: "user@examle.com",
                    password: "foobar", password_confirmation: "foobar")
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

  # nameの長さは大丈夫か？
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  # emailの長さは大丈夫か？
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  # 有効なメールフォーマットのテスト
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  # 無効なメールフォーマットのテスト
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                        foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  # 重複するメールアドレスを拒否するテスト
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  # メールアドレスの小文字化に対するテスト
  test "email addresses downcase" do
    mix_addresses_email = "Foo@ExAMPle.CoM"
    @user.email = mix_addresses_email
    @user.save
    assert_equal mix_addresses_email.downcase, @user.reload.email
  end

  # パスワードが空じゃないかのテスト
  test "password should be presence" do
    @user.password = @user.password_confirmation = "" * 6
    assert_not @user.valid?
  end

  # パスワードの最小文字数のテスト
  test "password should be minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  # ダイジェストが存在しない場合のauthenticated?のテスト
  test "authenticated? digest.nil?" do
    assert_not @user.authenticated?(:remember, "")
  end

  # (idを紐づけるための) ユーザーを作成そして紐付いたマイクロポストを作成
  # @userを削除した場合、Micropostの数が1つ減っているか
  test "micropost destroy" do
    @user.save
    @user.microposts.create!(content: "aaa")
    assert_difference "Micropost.count", -1 do
      @user.destroy
    end
  end
end
