class SessionsController < ApplicationController
  def login #new
  end

  def create
    # find_byはusersテーブルにindexを導入してるから使用可能(index = 辞書索引)
    # ユーザーをデータベースから見つけて検証する
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # 渡されたユーザーでログインする
      log_in user #sessions_helper
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      remember user #sessions_helper
      redirect_to user  #user_url(user)
      flash[:success] = "ログインしました"
    else
      flash.now[:danger] = "メールアドレスとパスワードのセットが違います"
      render 'login'
    end
  end

  def destroy
    #userがloginしているのであればloguotメソッド実行
    log_out if logged_in?
    redirect_to root_url
  end
end
