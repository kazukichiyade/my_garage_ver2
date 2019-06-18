require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "accouont_activation" do
    user = users(:kazukichi)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal ["noreply@example.com"], mail.from
    assert_equal [user.email], mail.to
    assert_equal "アカウント認証", mail.subject
    # ActionMailerで日本語メールを送る場合はエンコードを伴うテストは使えない
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
  end

end
