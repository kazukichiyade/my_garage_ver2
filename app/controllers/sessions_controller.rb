class SessionsController < ApplicationController
  def login #new
  end

  # ログインする
  def create
    # find_byはusersテーブルにindexを導入してるから使用可能(index = 辞書索引)
    # ユーザーをデータベースから見つけて検証する
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # 有効でないユーザーがログインすることのないようにする
      if user.activated?
        # 渡されたユーザーでログインする
        log_in user #sessions_helper
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user  #user_url(user)
        flash[:success] = "ログインしました"
      else
        message = "まだアカウントが認証されていません。"
        message += "メールをチェックしてください"
        flash[:warning] = message
        redirect_to root_url
      end
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
