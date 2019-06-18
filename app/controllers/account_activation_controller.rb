class AccountActivationController < ApplicationController

  # アカウントを有効化するアクション(!user.activated?は有効化一回にする為)
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "アカウントを認証しました"
      redirect_to user
    else
      flash[:danger] = "アカウントが認証できていません"
      redirect_to root_url
    end
  end

end
