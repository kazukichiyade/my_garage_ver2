class SessionsController < ApplicationController
  def new
  end

  def create
    # ユーザーをデータベースから見つけて検証する
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])

    else
      flash.now[:danger] = "メールアドレスとパスワードのセットが違います"
      render 'new'
    end
  end

  def destroy
  end
end
