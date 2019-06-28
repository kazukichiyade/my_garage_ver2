require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "accouont_activation" do
    user = users(:kazukichi)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal ["my_garage@example.com"], mail.from
    assert_equal [user.email], mail.to
    # 絶対誤差で比較テスト 誤差が3秒以内であればtrueになる
    assert_in_delta user.activated_at, Time.zone.now, 3
    assert_equal "アカウント認証", mail.subject

    # ActionMailerで日本語メールを送る場合はエンコードを伴うテストは使えない
    # assert_match user.name,               mail.body.encoded
    # assert_match user.activation_token,   mail.body.encoded
    # assert_match CGI.escape(user.email),  mail.body.encoded
  end

  test "password_reset" do
    user = users(:kazukichi)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal ["my_garage@example.com"], mail.from
    assert_equal [user.email], mail.to
    assert_in_delta user.reset_at, Time.zone.now, 3
    assert_equal "パスワードリセット", mail.subject
  end

end
