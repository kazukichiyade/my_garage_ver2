class AccountActivationController < ApplicationController

  # アカウントを有効化するアクション(!user.activated?は有効化一回にする為)
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "アカウントを認証しました"
      redirect_to user
    else
      flash[:danger] = "アカウントを認証できていません"
      redirect_to root_url
    end
  end

end
