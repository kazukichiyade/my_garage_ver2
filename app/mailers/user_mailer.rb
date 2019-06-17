class UserMailer < ApplicationMailer

  def accouont_activation(user)
    @user = user
    # subject = 件名
    mail to: user.email, subject: "Account activation"
  end

  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org"
  end
end
