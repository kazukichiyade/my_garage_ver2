module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # ユーザーのセッションを永続的にする
  def remember(user)
    user.remember
    # permanent = 期限を20年に設定 #signed = 署名付きcookie(安全に暗号化する)
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id]) #ユーザーIDが存在しない場合、コードが終了してnilを返す、# 代入した結果user_idのsessionが存在すれば)
      @current_user ||= User.find_by(id: user_id) # User.find_byを使う事で最初の一回だけリクエスト
    elsif (user_id = cookies.signed[:user_id]) 
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 永続的セッションを破棄(ログアウト)する
  def forget(user)
    user.forget # user.rememberを取り消す
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user) # forget(user)メソッドから呼び出し
    session.delete(:user_id)
    @current_user = nil
  end
end