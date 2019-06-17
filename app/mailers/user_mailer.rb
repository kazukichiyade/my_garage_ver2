class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "アカウント認証"
  end

  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org"
  end
end

# subject = 件名
# メールの動きを設定する