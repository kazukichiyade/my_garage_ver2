class UserMailer < ApplicationMailer

  # test/mailers/previews/user_mailer_preview.rbから
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "アカウント認証"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードリセット"
  end
end

# subject = 件名
# メールの動きを設定する