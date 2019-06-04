module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:user_id] #ユーザーIDが存在しない場合、コードが終了してnilを返す
      @current_user ||= User.find_by(id: session[:user_id]) # User.find_byを使う事で最初の一回だけリクエスト
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
end