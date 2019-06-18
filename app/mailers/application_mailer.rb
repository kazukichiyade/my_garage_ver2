class ApplicationMailer < ActionMailer::Base
  default from: "my_garage@example.com"
  layout 'mailer'
end

# メールの動きを設定する