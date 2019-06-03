class SessionsController < ApplicationController
  def login #new
  end

  def create
    # ユーザーをデータベースから見つけて検証する
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])

    else
      flash.now[:danger] = "メールアドレスとパスワードのセットが違います"
      render 'login'
    end
  end

  def destroy
  end
end
